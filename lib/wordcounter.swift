@objc class WordCounter: NSObject {
  @objc func countWords(_ input: String, result: FlutterResult) {
    let words = input.components(separatedBy: CharacterSet.whitespacesAndNewlines)
    result(words.count)
  }
}

static const platform = const MethodChannel('word_counter');

Future<int> countWords(String input) async {
  try {
    final int result = await platform.invokeMethod('countWords', input);
    return result;
  } on PlatformException catch (e) {
    print("Failed to count words: ${e.message}");
    return 0;
  }
}

int wordCount = await countWords("Hello world");
