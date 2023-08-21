import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watinsup/common/widgets/error_screen.dart';
import 'package:watinsup/common/widgets/loader.dart';
import 'package:watinsup/features/select_contact/controller/select_contact_controller.dart';

class SelectContactGroups extends ConsumerStatefulWidget {
  const SelectContactGroups({super.key});

  @override
  ConsumerState<SelectContactGroups> createState() =>
      _SelectContactGroupsState();
}

class _SelectContactGroupsState extends ConsumerState<SelectContactGroups> {
  List<int> selectedContactIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactIndex.contains(index)) {
      selectedContactIndex.removeAt(index);
    } else {
      selectedContactIndex.add(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
        data: (contactList) => Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () => selectContact(index, contact),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: selectedContactIndex.contains(index)
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.done,
                                ))
                            : null,
                      ),
                    ),
                  );
                })),
        error: (error, trace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () => const Loader());
  }
}
