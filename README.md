# LangGraph Client

The `langgraph_client` package is a Dart package that provides a client for the LangGraph API. It is based off the LangGraph `v.0.1.0` OpenAPI specification.
Both this package and the API itself are still in development and are subject to change.

## Features

The package supports the most vital APIs necessary to interact with the LangGraph API, but does not yet support the entire catalog of endpoints. Support for additional endpoints will be added in the near future.

## Getting started

Add the following to your **pubspec.yaml**:

```
dependencies:
  langgraph_client: "^0.1.0"
```

## Usage

Create an instance of the client:

```dart
var client = LangGraphClient(
  baseUrl: 'http://localhost:52273', // Replace with your LangGraph API URL
);
```

Create the input:

```dart

Thread thread = await client.createThread();

var statefulRequest = RunCreateStateful(
  assistantId: 'my-langgraph-agent',
  input: {
    'messages': [
      {
        'content': 'Write a Hello World program in Dart',
        'role': 'user',
      },
    ]
  },
  streamMode: 'messages',
);

```

Call the endpoint:

```dart
await for (final sseEvent in client.streamStatefulRun(thread.Id, statefulRequest)) {
  print(sseEvent);
}
```


## Additional information

For more information refer to the LangGraph documentation:
- [LangGraph API Specification](https://langchain-ai.github.io/langgraph/cloud/reference/api/api_ref.html)
- [Stream Modes](https://langchain-ai.github.io/langgraph/concepts/streaming/)
