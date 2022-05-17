import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/app_bars/default_app_bar.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/photo_card/photo_card.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/dividers/dividers.dart';
import 'package:isar/isar.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key, required this.photo, this.color})
      : super(key: key);

  ///The Photo.
  final Photo photo;

  ///Optional Color.
  final Color? color;

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  //Photo Reference.
  late Photo photo = widget.photo;

  //Highlight Color.
  late Color color = widget.color ?? sunbirdOrange;

  //Photo's MlTags.
  late List<MlTag> mlTags = isarDatabase!.mlTags
      .filter()
      .photoIDEqualTo(photo.id)
      .and()
      .blackListedEqualTo(false)
      .findAllSync();

  //Blacklisted MlTags.
  late List<MlTag> blacklistedMlTags = isarDatabase!.mlTags
      .filter()
      .photoIDEqualTo(photo.id)
      .and()
      .blackListedEqualTo(true)
      .findAllSync();

  //User Tags.
  final TextEditingController userTagsController = TextEditingController();
  final userTagsNode = FocusNode();

  late List<UserTag> userTags =
      isarDatabase!.userTags.filter().photoIDEqualTo(photo.id).findAllSync();

  bool bottomSheetVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
    );
  }

  ///APP BAR///
  AppBar _appBar() {
    return defaultAppBar(
      c: context,
      title: 'Photo',
      backgroundColor: color,
    );
  }

  ///BODY///
  GestureDetector _body() {
    return GestureDetector(
      onTap: () {
        setState(() {
          bottomSheetVisible = false;
        });
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            photoCard(context: context, photo: photo, color: color),
            defaultCard(body: _mlTagsBody(), color: color),
            defaultCard(body: _userTagsBody(), color: color),
            SizedBox(
              height: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  ///ML TAGS///
  Column _mlTagsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ml Tags',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        headingDivider(),
        Wrap(
          spacing: 5,
          runSpacing: 2.5,
          children: mlTags.map((e) => mlTagChip(e)).toList(),
        ),
        lightDivider(height: 16),
        Text(
          'Blacklist',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        headingDivider(),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: blacklistedMlTags.map((e) => mlTagChip(e)).toList(),
        ),
      ],
    );
  }

  ActionChip mlTagChip(MlTag mlTag) {
    return ActionChip(
      avatar: Builder(builder: (context) {
        switch (mlTag.tagType) {
          case MlTagType.text:
            return const Icon(
              Icons.format_size,
              size: 15,
            );

          case MlTagType.objectLabel:
            return const Icon(
              Icons.emoji_objects,
              size: 15,
            );

          case MlTagType.imageLabel:
            return const Icon(
              Icons.image,
              size: 15,
            );
        }
      }),
      label: Text(
        isarDatabase!.tagTexts.getSync(mlTag.textID)?.text ?? 'error',
      ),
      onPressed: () {
        if (mlTags.contains(mlTag)) {
          setState(() {
            //Move to blacklist.
            mlTags.remove(mlTag);
            blacklistedMlTags.add(mlTag);
          });

          //Write to database.
          mlTag.blackListed = true;
          isarDatabase!.writeTxn(
              (isar) => isar.mlTags.put(mlTag, replaceOnConflict: true));
        } else {
          setState(() {
            //Move to mlTags.
            mlTags.add(mlTag);
            blacklistedMlTags.remove(mlTag);
          });

          //Write to database.
          mlTag.blackListed = false;
          isarDatabase!.writeTxn(
              (isar) => isar.mlTags.put(mlTag, replaceOnConflict: true));
        }
      },
      tooltip: mlTag.tagType.name.toString().capitalize(),
      backgroundColor: color,
    );
  }

  ///USER TAGS///
  Column _userTagsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Tags',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        headingDivider(),
        Builder(builder: (context) {
          List<Widget> widgets = [
            newUserTagChip(),
          ];
          widgets.addAll(userTags.map((e) => userTagChip(e)));
          return Wrap(
            spacing: 5,
            runSpacing: 2.5,
            children: widgets,
          );
        }),
      ],
    );
  }

  ActionChip userTagChip(UserTag userTag) {
    return ActionChip(
      label: Text(
        isarDatabase!.tagTexts.getSync(userTag.textID)?.text ?? 'error',
      ),
      onPressed: () {
        //RemoveTag()
        removeTag(userTag);
      },
      backgroundColor: color,
    );
  }

  Visibility newUserTagChip() {
    return Visibility(
      visible: !bottomSheetVisible,
      child: ActionChip(
        label: Text(
          '+',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onPressed: () {
          setState(() {
            bottomSheetVisible = !bottomSheetVisible;
            userTagsNode.requestFocus();
          });
        },
      ),
    );
  }

  ///NEW USER TAGS///
  Visibility _bottomSheet() {
    return Visibility(
      visible: bottomSheetVisible,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tags',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            _tagSelector(),
            lightDivider(height: 16),
            _userTagTextField(),
          ],
        ),
      ),
    );
  }

  TextField _userTagTextField() {
    return TextField(
      focusNode: userTagsNode,
      controller: userTagsController,
      onChanged: (value) {
        setState(() {});
      },
      onSubmitted: (value) {
        addNewUserTag(value);
        userTagsNode.requestFocus();
        userTagsController.clear();
      },
      style: const TextStyle(fontSize: 18),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: 'Tag',
        labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: () {
            addNewUserTag(userTagsController.text);
            userTagsNode.requestFocus();
            userTagsController.clear();
          },
          icon: const Icon(Icons.add),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: color)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color)),
      ),
    );
  }

  SingleChildScrollView _tagSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Builder(builder: (context) {
        List<TagText> tagTexts = [];
        List<int> usedText = userTags.map((e) => e.textID).toList();

        tagTexts = isarDatabase!.tagTexts
            .filter()
            .textContains(userTagsController.text.toLowerCase(),
                caseSensitive: false)
            .findAllSync()
            .toList();

        tagTexts.removeWhere((element) => usedText.contains(element.id));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Wrap(
            spacing: 5,
            children: tagTexts.map((e) => tagTextChip(e)).take(15).toList(),
          ),
        );
      }),
    );
  }

  ActionChip tagTextChip(TagText tagText) {
    return ActionChip(
      label: Text(tagText.text),
      onPressed: () {
        //Add Tag.
        addUserTag(tagText);
      },
      backgroundColor: color,
    );
  }

  void addUserTag(TagText tagText) {
    UserTag userTag = UserTag()
      ..photoID = photo.id
      ..textID = tagText.id;
    isarDatabase!.writeTxnSync((isar) => isar.userTags.putSync(userTag));
    setState(() {
      userTags.add(userTag);
      userTagsController.clear();
    });
  }

  void addNewUserTag(String text) {
    if (text.isNotEmpty) {
      text.toLowerCase().trim();
      TagText? tagText =
          isarDatabase!.tagTexts.filter().textMatches(text).findFirstSync();
      if (tagText == null) {
        TagText newTagText = TagText()..text = text;
        isarDatabase!.writeTxnSync((isar) => isar.tagTexts.putSync(newTagText));
        UserTag newUserTag = UserTag()
          ..photoID = photo.id
          ..textID = newTagText.id;

        isarDatabase!.writeTxn((isar) => isar.userTags.put(newUserTag));
        setState(() {
          userTags.add(newUserTag);
        });
      }
    } else {
      setState(() {
        userTagsNode.unfocus();
        bottomSheetVisible = false;
      });
    }
  }

  void removeTag(UserTag userTag) {
    setState(() {
      userTags.remove(userTag);
    });
    isarDatabase!.writeTxn((isar) => isar.userTags.delete(userTag.id));
  }
}
