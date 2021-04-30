import pika
import random
import time
from model_runner import translateSentence

print(translateSentence('Je vais dormir.'))

def on_request(ch, method, props, body):
    r = random.randrange(1, 1000)
    response = translateSentence(str(body, 'utf-8'))
    ch.basic_publish(exchange='',
                     routing_key=props.reply_to,
                     properties=pika.BasicProperties(
                         correlation_id=props.correlation_id),
                     body=str(response))
    ch.basic_ack(delivery_tag=method.delivery_tag)


channel = None

while channel == None:
    try:
        connection = pika.BlockingConnection(
            pika.ConnectionParameters(host='rabbitmq'))
        channel = connection.channel()
    except:
        print("Retrying in 1sec")
        time.sleep(1)

channel.queue_declare(queue='rpc_queue')
channel.basic_qos(prefetch_count=1)
channel.basic_consume(queue='rpc_queue', on_message_callback=on_request)

print(" [x] Awaiting RPC requests")
channel.start_consuming()
