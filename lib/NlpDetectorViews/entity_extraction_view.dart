import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class EntityExtractionView extends StatefulWidget {
  @override
  _EntityExtractionViewState createState() => _EntityExtractionViewState();
}

class _EntityExtractionViewState extends State<EntityExtractionView> {
  final _controller = TextEditingController();

  final _languageModelManager = GoogleMlKit.nlp.entityModelManager();

  final _entityExtractor =
      GoogleMlKit.nlp.entityExtractor(EntityExtractorOptions.ENGLISH);

  @override
  void dispose() {
    _entityExtractor.close();
    super.dispose();
  }

  Future<void> downloadModel() async {
    var result = await _languageModelManager
        .downloadModel(EntityExtractorOptions.ENGLISH, isWifiRequired: false);
    print('Model downloaded: $result');
  }

  Future<void> deleteModel() async {
    var result =
        await _languageModelManager.deleteModel(EntityExtractorOptions.ENGLISH);
    print('Model deleted: $result');
  }

  Future<void> getAvailableModels() async {
    var result = await _languageModelManager.getAvailableModels();
    print('Available models: $result');
  }

  Future<void> isModelDownloaded() async {
    var result = await _languageModelManager
        .isModelDownloaded(EntityExtractorOptions.ENGLISH);
    print('Model download: $result');
  }

  Future<void> translateText() async {
    var result = await _entityExtractor.extractEntities(_controller.text);
    for (var element in result) {
      print(element.entities);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Entity Extractor"),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(child: Text('Enter text (English)')),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                )),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(border: InputBorder.none),
                  maxLines: null,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: translateText,
                  child: const Text('Extract Entities'))
            ]),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: downloadModel,
                    child: const Text('Download Model')),
                ElevatedButton(
                    onPressed: deleteModel, child: const Text('Delete Model')),
              ],
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  onPressed: getAvailableModels,
                  child: const Text('Get Available models')),
              ElevatedButton(
                  onPressed: isModelDownloaded,
                  child: const Text('Check download'))
            ])
          ],
        ),
      ),
    );
  }
}
