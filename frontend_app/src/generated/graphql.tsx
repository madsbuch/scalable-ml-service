import { gql } from '@apollo/client';
import * as Apollo from '@apollo/client';
export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
const defaultOptions =  {}
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
};

export type AddStringPairInput = {
  sourceLangCode: Scalars['String'];
  sourceString: Scalars['String'];
  targetLangCode: Scalars['String'];
  targetString: Scalars['String'];
};

export type AddStringPairPayload = {
  __typename?: 'AddStringPairPayload';
  status?: Maybe<Scalars['String']>;
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  /** Adds a string pair to the database */
  addStringPair?: Maybe<AddStringPairPayload>;
};


export type RootMutationTypeAddStringPairArgs = {
  input: AddStringPairInput;
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  /** Get a translation of a string */
  translate?: Maybe<TranslationResponse>;
};


export type RootQueryTypeTranslateArgs = {
  sentence: Scalars['String'];
};

/** A response to a translation request */
export type TranslationResponse = {
  __typename?: 'TranslationResponse';
  translatedString?: Maybe<Scalars['String']>;
};

export type TranslateQueryVariables = Exact<{
  sentence: Scalars['String'];
}>;


export type TranslateQuery = (
  { __typename?: 'RootQueryType' }
  & { translate?: Maybe<(
    { __typename?: 'TranslationResponse' }
    & Pick<TranslationResponse, 'translatedString'>
  )> }
);


export const TranslateDocument = gql`
    query Translate($sentence: String!) {
  translate(sentence: $sentence) {
    translatedString
  }
}
    `;

/**
 * __useTranslateQuery__
 *
 * To run a query within a React component, call `useTranslateQuery` and pass it any options that fit your needs.
 * When your component renders, `useTranslateQuery` returns an object from Apollo Client that contains loading, error, and data properties
 * you can use to render your UI.
 *
 * @param baseOptions options that will be passed into the query, supported options are listed on: https://www.apollographql.com/docs/react/api/react-hooks/#options;
 *
 * @example
 * const { data, loading, error } = useTranslateQuery({
 *   variables: {
 *      sentence: // value for 'sentence'
 *   },
 * });
 */
export function useTranslateQuery(baseOptions: Apollo.QueryHookOptions<TranslateQuery, TranslateQueryVariables>) {
        const options = {...defaultOptions, ...baseOptions}
        return Apollo.useQuery<TranslateQuery, TranslateQueryVariables>(TranslateDocument, options);
      }
export function useTranslateLazyQuery(baseOptions?: Apollo.LazyQueryHookOptions<TranslateQuery, TranslateQueryVariables>) {
          const options = {...defaultOptions, ...baseOptions}
          return Apollo.useLazyQuery<TranslateQuery, TranslateQueryVariables>(TranslateDocument, options);
        }
export type TranslateQueryHookResult = ReturnType<typeof useTranslateQuery>;
export type TranslateLazyQueryHookResult = ReturnType<typeof useTranslateLazyQuery>;
export type TranslateQueryResult = Apollo.QueryResult<TranslateQuery, TranslateQueryVariables>;