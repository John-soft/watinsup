// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:watinsup/features/select_contact/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return SelectedContactController(
    ref: ref,
    selectedContactRepository: selectContactRepository,
  );
});

class SelectedContactController {
  final ProviderRef ref;
  final SelectContactRepository selectedContactRepository;

  SelectedContactController({
    required this.ref,
    required this.selectedContactRepository,
  });

  void selectedContact(Contact selectedContact, BuildContext context) {
    selectedContactRepository.selectContact(selectedContact, context);
  }
}
