import 'package:flutter/material.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository.dart';
import 'package:devotions_app/shared/models/activity_note_create_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Page for creating a new activity note
class CreateActivityNotePage extends StatefulWidget {
  const CreateActivityNotePage({super.key});

  @override
  State<CreateActivityNotePage> createState() => _CreateActivityNotePageState();
}

class _CreateActivityNotePageState extends State<CreateActivityNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String _selectedNoteType = 'General';
  bool _isSubmitting = false;

  final List<String> _noteTypes = [
    'General',
    'Prayer',
    'Testimony',
    'Announcement',
    'Other'
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final repository = context.read<ActivityNoteRepository>();
      final tokenState = context.read<TokenCubit>().state;
      final orgId = tokenState.orgId?.toString() ?? '';
      final branchId = tokenState.branch ?? '';

      final activityNote = ActivityNoteCreateDto(
        noteTypeName: _selectedNoteType,
        text: _noteController.text,
        organizationId: tokenState.orgId,
        branchId: branchId,
      );

      await repository.createActivityNote(
        activityNote,
        orgId,
        branchId,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Activity note created successfully'),
          backgroundColor: Colors.green,
        ),
      );

      context.pop(true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating activity note: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Activity Note',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade900,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: false,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Note Type Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedNoteType,
                  decoration: const InputDecoration(
                    labelText: 'Note Type',
                    border: OutlineInputBorder(),
                  ),
                  items: _noteTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedNoteType = value!);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a note type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Note Content
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter note content';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.indigo.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Create Note',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 