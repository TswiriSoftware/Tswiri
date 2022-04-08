import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:flutter_google_ml_kit/sunbird_views/photo_tagging/object_detector_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import 'add_container_view_new.dart';
import 'objects/photo_data.dart';

class ContainerViewNew extends StatefulWidget {
  const ContainerViewNew(
      {Key? key, required this.containerEntry, this.navigatorHistory})
      : super(key: key);

  final ContainerEntry containerEntry;
  final List<ContainerEntry>? navigatorHistory;

  @override
  State<ContainerViewNew> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<ContainerViewNew> {
  //Conmtainer.
  late ContainerEntry containerEntry;
  late Color containerColor;

  //Container Name.
  TextEditingController nameController = TextEditingController();

  //Container Description.
  TextEditingController descriptionController = TextEditingController();

  //Tags
  TextEditingController tagController = TextEditingController();

  bool editting = false;
  bool showChildren = false;
  bool showTagEditor = false;
  bool showTagSave = false;

  List<int> assignedTags = [];
  List<int> allTags = [];
  //List<int> unassignedTags = [];

  //Styling
  late Color outlineColor;

  //Other
  int length = 1;

  @override
  void initState() {
    if (widget.navigatorHistory != null) {
      length = length + widget.navigatorHistory!.length;
    }
    containerEntry = widget.containerEntry;

    containerColor =
        getContainerColor(containerUID: containerEntry.containerUID);

    outlineColor = containerColor.withOpacity(0.6);

    nameController.text = containerEntry.name ?? containerEntry.containerUID;
    descriptionController.text = containerEntry.description ?? '';

    assignedTags = isarDatabase!.containerTags
        .filter()
        .containerUIDMatches(containerEntry.containerUID)
        .tagIDProperty()
        .findAllSync();

    allTags =
        isarDatabase!.tags.where().findAllSync().map((e) => e.id).toList();

    log(widget.navigatorHistory.toString());

    super.initState();
  }

  @override
  void dispose() {
    if (widget.navigatorHistory != null) {
      widget.navigatorHistory!.removeLast();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          containerEntry.name ?? containerEntry.containerUID,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Nav History///
            _navigationHistory(),

            ///Info Tile///
            _infoTile(),
            const Divider(),

            ///Children Tile///
            _childrenTile(),
            const Divider(),

            ///Tags Tile///
            _tagsTile(),
            const Divider(),

            //Photos///
            _photosTile(),
            const Divider(),

            //Photo Tags///
            _photoTagsTile(),

            //Spacing
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            )
          ],
        ),
      ),
    );
  }

  ///INFO TILE///

  Widget _infoTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent, //COLORS URG
      child: CustomOutlineContainer(
        outlineColor: outlineColor,
        // backgroundColor: Colors.transparent,
        margin: 2.5,
        padding: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Container Info',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  _modifyInfoButton(),
                ],
              ),
            ),
            _dividerHeavy(),
            _infoBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _infoBuilder() {
    return Builder(builder: (context) {
      if (editting) {
        return Column(
          children: [
            _nameTextField(),
            _descriptionTextField(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _name(),
            _dividerLight(),
            _description(),
          ],
        );
      }
    });
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            nameController.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            descriptionController.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              // name = value;
            });
          } else {
            setState(() {
              // name = null;
            });
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: descriptionController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              //description = value;
            });
          } else {
            setState(() {
              //description = null;
            });
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
        ),
      ),
    );
  }

  Widget _modifyInfoButton() {
    return InkWell(
      onTap: () {
        //Change is editting.
        editting = !editting;

        //Check nameController.text and modify ContainerEntry.
        if (nameController.text.isNotEmpty) {
          containerEntry.name = nameController.text;
        } else {
          containerEntry.name = null;
        }

        //Check descriptionController.text and modify ContainerEntry.
        if (descriptionController.text.isNotEmpty) {
          containerEntry.description = descriptionController.text;
        } else {
          containerEntry.description = null;
        }

        //Write ContainerEntry.
        isarDatabase!.writeTxnSync(
            (isar) => isar.containerEntrys.putSync(containerEntry));

        //Update Widget.
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineContainer(
            backgroundColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Builder(builder: (context) {
                if (editting) {
                  return Row(
                    children: [
                      Text(
                        'save',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.save,
                        size: 20,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        'edit',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ],
                  );
                }
              }),
            ),
            outlineColor: containerColor,
          ),
        ],
      ),
    );
  }

  ///CHILDREN TILE///

  Widget _childrenTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent,
      child: CustomOutlineContainer(
        outlineColor: outlineColor,
        margin: 2.5,
        padding: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //TODO: Come up with a more apropriate name.
                    'Children ***',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  _showChildrenButton(),
                ],
              ),
            ),
            _dividerHeavy(),
            _childrenBuilder(),
            _dividerLight(),
            _childrenActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _childrenBuilder() {
    return Builder(builder: (context) {
      List<ContainerRelationship> numberOfChildren = [];
      numberOfChildren.addAll(isarDatabase!.containerRelationships
          .filter()
          .parentUIDMatches(containerEntry.containerUID)
          .findAllSync());
      if (showChildren) {
        return LightContainer(
          backgroundColor: Colors.white10.withOpacity(0.05),
          child: Column(
            children:
                numberOfChildren.map((e) => childContainerWidget(e)).toList(),
          ),
        );
      } else {
        return LightContainer(
            backgroundColor: Colors.white10.withOpacity(0.05),
            child: Row(
              children: [
                Text(
                  'Number of Children: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  numberOfChildren.length.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ));
      }
    });
  }

  Widget childContainerWidget(ContainerRelationship containerRelationship) {
    return Builder(builder: (context) {
      ContainerEntry childContainerEntry = isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(containerRelationship.containerUID)
          .findFirstSync()!;

      Color childColor =
          getContainerColor(containerUID: childContainerEntry.containerUID);

      return CustomOutlineContainer(
        backgroundColor: Colors.white10.withOpacity(0.05),
        margin: 2.5,
        padding: 5,
        outlineColor: childColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name/UID',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  childContainerEntry.name ?? childContainerEntry.containerUID,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  childContainerEntry.description ?? '-',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                List<ContainerEntry> navigatorHistory =
                    widget.navigatorHistory ?? [];
                if (widget.navigatorHistory != null &&
                    widget.navigatorHistory!.last.barcodeUID !=
                        containerEntry.containerUID) {
                  navigatorHistory.add(containerEntry);
                } else if (widget.navigatorHistory == null) {
                  navigatorHistory.add(containerEntry);
                }

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContainerViewNew(
                            containerEntry: childContainerEntry,
                            navigatorHistory: navigatorHistory,
                          )),
                );
                setState(() {});
              },
              child: CustomOutlineContainer(
                  backgroundColor: childColor.withOpacity(0.5),
                  margin: 5,
                  padding: 2.5,
                  outlineColor: childColor,
                  child: const Icon(
                    Icons.edit,
                    size: 30,
                  )),
            ),
          ],
        ),
      );
    });
  }

  Widget _showChildrenButton() {
    return InkWell(
      onTap: () {
        //Change is editting.
        showChildren = !showChildren;

        //Update Widget.
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineContainer(
            backgroundColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Builder(builder: (context) {
                if (showChildren) {
                  return Row(
                    children: [
                      Text(
                        'hide',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_drop_up,
                        size: 20,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        'show',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                      ),
                    ],
                  );
                }
              }),
            ),
            outlineColor: containerColor,
          ),
        ],
      ),
    );
  }

  Widget _childrenActionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _addMultipleChildren(),
          _addSingleChild(),
        ],
      ),
    );
  }

  Widget _addSingleChild() {
    return InkWell(
      onTap: () async {
        //ACTION add Single.
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddContainerViewNew(
              parentContainer: containerEntry,
            ),
          ),
        );
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineContainer(
            backgroundColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Row(
                children: [
                  Text(
                    'add single',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ],
              ),
            ),
            outlineColor: containerColor,
          ),
        ],
      ),
    );
  }

  Widget _addMultipleChildren() {
    return InkWell(
      onTap: () {
        setState(() {
          //ACTION Add Multiple.
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineContainer(
            backgroundColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Row(
                children: [
                  Text(
                    'add multiple',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.add_to_photos,
                    size: 20,
                  ),
                ],
              ),
            ),
            outlineColor: containerColor,
          ),
        ],
      ),
    );
  }

  ///TAGS///

  Widget _tagsTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent,
      child: CustomOutlineContainer(
        outlineColor: containerColor.withOpacity(0.8),
        margin: 2.5,
        padding: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tags',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  _tagExpansionButtonBuilder(),
                ],
              ),
            ),
            _dividerHeavy(),
            _assignedTagsBuilder(),
            _unAssignedTagsBuilder(),
            _tagTextFieldBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _assignedTagsBuilder() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assigned Tags', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              runSpacing: 5,
              spacing: 5,
              children: assignedTags.map((e) => tag(e)).toList(),
            ),
          ],
        ),
      );
    });
  }

  Widget _unAssignedTagsBuilder() {
    return Builder(builder: (context) {
      List<int> displayTags = [];
      displayTags.addAll(isarDatabase!.tags
          .filter()
          .tagContains(tagController.text.toLowerCase(), caseSensitive: false)
          .findAllSync()
          .map((e) => e.id)
          .where((element) => !assignedTags.contains(element)));

      if (showTagEditor) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dividerLight(),
              Text('Unassigned Tags',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                children: displayTags.map((e) => tag(e)).toList(),
              ),
            ],
          ),
        );
      } else {
        return Row();
      }
    });
  }

  Widget tag(int tagID) {
    return InkWell(
      onTap: () {
        if (assignedTags.contains(tagID) && showTagEditor == true) {
          setState(() {
            assignedTags.removeWhere((element) => element == tagID);
            showTagSave = true;
          });
        } else if (!assignedTags.contains(tagID)) {
          setState(() {
            assignedTags.add(tagID);
            showTagSave = true;
          });
        } else {
          //Throw exception to let user know they need to enter edit mode
        }
      },
      child: Container(
        child: Builder(builder: (context) {
          String tag = isarDatabase!.tags.getSync(tagID)!.tag;
          return Text(tag);
        }),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: containerColor, width: 1),
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            color: Colors.white10),
      ),
    );
  }

  Widget _tagExpansionButtonBuilder() {
    return InkWell(
      onTap: () {
        //Change is editting.
        showTagEditor = !showTagEditor;
        saveTags();

        //Update Widget.
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlineContainer(
            backgroundColor: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Builder(builder: (context) {
                if (showTagEditor) {
                  return Row(
                    children: [
                      Text(
                        'save',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.save,
                        size: 20,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        'edit',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ],
                  );
                }
              }),
            ),
            outlineColor: containerColor,
          ),
        ],
      ),
    );
  }

  void saveTags() {
    //Find existing container Tags.
    List<ContainerTag> containerTags = [];
    containerTags.addAll(isarDatabase!.containerTags
        .filter()
        .containerUIDMatches(containerEntry.containerUID)
        .findAllSync());

    //Remove existing container Tags.
    isarDatabase!.writeTxnSync((isar) => isar.containerTags
        .filter()
        .containerUIDMatches(containerEntry.containerUID)
        .deleteAllSync());

    List<ContainerTag> newContainerTags = assignedTags
        .map((tagID) => ContainerTag()
          ..containerUID = containerEntry.containerUID
          ..tagID = tagID)
        .toList();

    isarDatabase!.writeTxnSync(
        (isar) => isar.containerTags.putAllSync(newContainerTags));

    log(newContainerTags.toString());
  }

  Widget _tagTextFieldBuilder() {
    return Builder(builder: (context) {
      if (showTagEditor) {
        return CustomOutlineContainer(
          outlineColor: containerColor,
          margin: 5,
          padding: 8,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tagController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: const TextStyle(fontSize: 18),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelText: 'New Tag...',
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: containerColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: containerColor)),
                  ),
                ),
              ),
              Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    //Check if tag exists
                    Tag? exists = isarDatabase!.tags
                        .filter()
                        .tagMatches(tagController.text.trim(),
                            caseSensitive: false)
                        .findFirstSync();

                    String inputValue = tagController.text;

                    if (exists == null && inputValue.isNotEmpty) {
                      //Remove white spaces
                      inputValue.trim();

                      Tag newTag = Tag()..tag = inputValue;
                      isarDatabase!.writeTxnSync(
                        (isar) => isar.tags.putSync(newTag),
                      );

                      tagController.text = '';
                      assignedTags.add(newTag.id);
                      updateTags();
                      setState(() {});
                    }
                  },
                  child: CustomOutlineContainer(
                    backgroundColor: containerColor,
                    margin: 2.5,
                    padding: 5,
                    outlineColor: containerColor,
                    child: const Icon(Icons.add),
                  ),
                );
              })
            ],
          ),
        );
      } else {
        return Row();
      }
    });
  }

  void updateTags() {
    allTags =
        isarDatabase!.tags.where().findAllSync().map((e) => e.id).toList();
  }

  ///PHOTOS///

  Widget _photosTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent,
      child: CustomOutlineContainer(
        outlineColor: containerColor.withOpacity(0.8),
        // backgroundColor: Colors.transparent,
        margin: 2.5,
        padding: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Photo(s)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  _photoAddButton(),
                ],
              ),
            ),
            _dividerHeavy(),
            _photoBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _photoBuilder() {
    return Builder(builder: (context) {
      List<ContainerPhoto> containerPhotos = [];
      containerPhotos.addAll(isarDatabase!.containerPhotos
          .filter()
          .containerUIDMatches(containerEntry.containerUID)
          .findAllSync());

      if (containerPhotos.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Wrap(
            runSpacing: 5,
            spacing: 8,
            children:
                containerPhotos.map((e) => photoDisplayWidget(e)).toList(),
          ),
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'no photos',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        );
      }
    });
  }

  Widget photoDisplayWidget(ContainerPhoto containerPhoto) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.29,
          child: CustomOutlineContainer(
            outlineColor: containerColor,
            padding: 2,
            child: Image.file(
              File(containerPhoto.photoPath),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            //Delete Photo.
            File(containerPhoto.photoPath).delete();

            //Delete Photo Thumbnail.
            File(isarDatabase!.containerPhotoThumbnails
                    .filter()
                    .photoPathMatches(containerPhoto.photoPath)
                    .findFirstSync()!
                    .thumbnailPhotoPath)
                .delete();

            //Delete References from database.
            isarDatabase!.writeTxnSync((isar) {
              isar.containerPhotos
                  .filter()
                  .photoPathMatches(containerPhoto.photoPath)
                  .deleteFirstSync();
              isar.containerPhotoThumbnails
                  .filter()
                  .photoPathMatches(containerPhoto.photoPath)
                  .deleteFirstSync();
              isar.photoTags
                  .filter()
                  .photoPathMatches(containerPhoto.photoPath)
                  .deleteAllSync();
            });

            setState(() {});
          },
          icon: const Icon(Icons.delete),
          color: containerColor,
        ),
      ],
    );
  }

  Widget _photoAddButton() {
    return InkWell(
      onTap: () async {
        PhotoData? photoData = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectDetectorView(
              customColor: containerColor,
            ),
          ),
        );
        if (photoData != null) {
          addNewPhoto(photoData);
          setState(() {});
        }
      },
      child: CustomOutlineContainer(
          backgroundColor: Colors.white10,
          margin: 2.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'add',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.camera,
                  size: 20,
                ),
              ],
            ),
          ),
          outlineColor: containerColor),
    );
  }

  void addNewPhoto(PhotoData photoData) {
    ContainerPhoto newContainerPhoto = ContainerPhoto()
      ..containerUID = containerEntry.containerUID
      ..photoPath = photoData.photoPath;

    ContainerPhotoThumbnail newThumbnail = ContainerPhotoThumbnail()
      ..photoPath = photoData.photoPath
      ..thumbnailPhotoPath = photoData.thumbnailPhotoPath;

    List<PhotoTag> newPhotoTags = [];

    for (DetectedObject detectedObject in photoData.photoObjects) {
      List<Label> labels = detectedObject.getLabels();

      for (Label label in labels) {
        int mlTagID = isarDatabase!.mlTags
            .filter()
            .tagMatches(label.getText().toLowerCase())
            .and()
            .tagTypeEqualTo(mlTagType.objectLabel)
            .findFirstSync()!
            .id;

        List<double> boundingBox = [
          detectedObject.getBoundinBox().left,
          detectedObject.getBoundinBox().top,
          detectedObject.getBoundinBox().right,
          detectedObject.getBoundinBox().bottom
        ];

        PhotoTag newPhotoTag = PhotoTag()
          ..photoPath = photoData.photoPath
          ..tagUID = mlTagID
          ..boundingBox = boundingBox
          ..confidence = label.getConfidence();

        newPhotoTags.add(newPhotoTag);
      }
    }

    for (ImageLabel imageLabel in photoData.photoLabels) {
      int mlTagID = isarDatabase!.mlTags
          .filter()
          .tagMatches(imageLabel.label.toLowerCase())
          .and()
          .tagTypeEqualTo(mlTagType.imageLabel)
          .findFirstSync()!
          .id;

      PhotoTag newPhotoTag = PhotoTag()
        ..photoPath = photoData.photoPath
        ..tagUID = mlTagID
        ..boundingBox = null
        ..confidence = imageLabel.confidence;

      newPhotoTags.add(newPhotoTag);
    }

    for (TextBlock textBlock in photoData.recognisedTexts.blocks) {
      if (textBlock.text.length >= 4) {
        int mlTagID = isarDatabase!.mlTags
            .filter()
            .tagMatches(textBlock.text.toLowerCase())
            .and()
            .tagTypeEqualTo(mlTagType.text)
            .findFirstSync()!
            .id;

        PhotoTag newPhotoTag = PhotoTag()
          ..photoPath = photoData.photoPath
          ..tagUID = mlTagID
          ..boundingBox = null
          ..confidence = 1;

        newPhotoTags.add(newPhotoTag);
      }
    }

    isarDatabase!.writeTxnSync((isar) {
      isar.containerPhotos.putSync(newContainerPhoto);
      isar.containerPhotoThumbnails.putSync(newThumbnail);
      isar.photoTags.putAllSync(newPhotoTags);
    });
  }

  ///PHOTO TAGS///

  Widget _photoTagsTile() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      backgroundColor: Colors.transparent,
      child: CustomOutlineContainer(
        outlineColor: containerColor.withOpacity(0.8),
        // backgroundColor: Colors.transparent,
        margin: 2.5,
        padding: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Photo Tags',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _dividerHeavy(),
            _photoTagsBuilder(),
          ],
        ),
      ),
    );
  }

  Widget _photoTagsBuilder() {
    return Builder(builder: (context) {
      List<MlTag> mlTags = [];
      List<PhotoTag> photoTags = [];

      List<ContainerPhoto> containerPhotos = isarDatabase!.containerPhotos
          .filter()
          .containerUIDMatches(containerEntry.containerUID)
          .findAllSync();

      if (containerPhotos.isNotEmpty) {
        photoTags = isarDatabase!.photoTags
            .filter()
            .repeat(
                containerPhotos,
                (q, ContainerPhoto element) =>
                    q.photoPathMatches(element.photoPath))
            .findAllSync();

        if (photoTags.isNotEmpty) {
          mlTags = isarDatabase!.mlTags
              .filter()
              .repeat(photoTags,
                  (q, PhotoTag element) => q.idEqualTo(element.tagUID))
              .findAllSync();
        }
      }
      if (mlTags.isNotEmpty) {
        return Wrap(
          runSpacing: 5,
          spacing: 5,
          children: mlTags.map((e) => photoTag(e)).toList(),
        );
      } else {
        return Center(
          child: Text(
            'no tags',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      }
    });
  }

  Widget photoTag(MlTag mlTag) {
    return Container(
      child: Text(mlTag.tag),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: containerColor, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.white10),
    );
  }

  ///MISC///

  Widget _navigationHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: CustomOutlineContainer(
        outlineColor: Colors.white38,
        padding: 5,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: ((context, index) {
              if (index == length - 1) {
                return Row(
                  children: [
                    Builder(builder: (context) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List<int>.generate(index + 1, (i) => i + 1)
                            .map((e) => spacingContainer(containerEntry))
                            .toList(),
                      );
                    }),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      containerEntry.containerUID,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Builder(builder: (context) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List<int>.generate(index + 1, (i) => i + 1)
                            .map((e) => spacingContainer(
                                widget.navigatorHistory![index]))
                            .toList(),
                      );
                    }),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.navigatorHistory![index].name ??
                          widget.navigatorHistory![index].containerUID,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                );
              }
            })),
      ),
    );
  }

  Widget spacingContainer(ContainerEntry containerEntry) {
    return Container(
      height: 2.5,
      width: 25,
      color: getContainerColor(containerUID: containerEntry.containerUID),
    );
  }

  Widget _dividerLight() {
    return const Divider(
      height: 10,
      thickness: .5,
      color: Colors.white54,
    );
  }

  Widget _dividerHeavy() {
    return const Divider(
      height: 10,
      thickness: 1,
      color: Colors.white,
    );
  }
}
