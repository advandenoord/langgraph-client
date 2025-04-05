import 'package:langgraph_client/langgraph_client.dart';

void main() {
  streamStatefulRun();
}

// https://langchain-ai.github.io/langgraph/cloud/reference/api/api_ref.html#tag/thread-runs/POST/threads/{thread_id}/runs/stream
void streamStatefulRun() async {
  var client = LangGraphClient(
    baseUrl: 'http://localhost:52273', // Replace with your LangGraph API URL
  );

  Thread thread = await client.createThread();

  var statefulRequest = RunCreateStateful(
    assistantId: 'my-langgraph-agent', // Replace with your assistant ID
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

  await for (final sseEvent
      in client.streamStatefulRun(thread.threadId, statefulRequest)) {
    print(sseEvent);
  }
}
