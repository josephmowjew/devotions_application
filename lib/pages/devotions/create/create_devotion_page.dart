import 'package:devotions_app/shared/models/devotion_create.dart';
import 'package:devotions_app/shared/repositories/devotions_repository.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

/// A page that allows creating a new devotion
class CreateDevotionPage extends StatefulWidget {
  /// Creates a page for creating a new devotion
  const CreateDevotionPage({Key? key}) : super(key: key);

  /// Route name for navigation
  static const String routeName = '/devotions/create';

  @override
  State<CreateDevotionPage> createState() => _CreateDevotionPageState();
}

class _CreateDevotionPageState extends State<CreateDevotionPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _scriptureReadingController = TextEditingController();
  final _scriptureTextController = TextEditingController();
  final _devotionController = TextEditingController();
  final _prayerController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    _scriptureReadingController.dispose();
    _scriptureTextController.dispose();
    _devotionController.dispose();
    _prayerController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Get token state for auth data
      final tokenState = context.read<TokenCubit>().state;
      final orgId = tokenState.orgId != null ? tokenState.orgId.toString() : '';
      final branchId = tokenState.branch ?? '';

      if (orgId.isEmpty || branchId.isEmpty) {
        throw Exception('Organisation or branch data missing');
      }

      // Create the devotion object
      final devotion = DevotionCreate(
        title: _titleController.text,
        scriptureReading: _scriptureReadingController.text,
        scriptureText: _scriptureTextController.text,
        devotion: _devotionController.text,
        prayer: _prayerController.text,
      );


      // Submit to repository
      final repository = context.read<DevotionsRepository>();
    

      await repository.createDevotion(devotion, orgId, branchId);

      // Return to previous screen on success
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Devotion created successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error creating devotion: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Create Devotion',
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.indigo.shade800),
          onPressed: () => context.pop(),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Error message if any
                        if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red.shade800),
                              ),
                            ),
                          ),

                        // Title field
                        _buildInputField(
                          controller: _titleController,
                          label: 'Title',
                          hintText: 'Enter devotion title',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Scripture Reference
                        _buildInputField(
                          controller: _scriptureReadingController,
                          label: 'Scripture Reference',
                          hintText: 'E.g., John 3:16',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a scripture reference';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Scripture Text
                        _buildInputField(
                          controller: _scriptureTextController,
                          label: 'Scripture Text',
                          hintText: 'Enter the scripture verse text',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter scripture text';
                            }
                            return null;
                          },
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),

                        // Devotion Content
                        _buildInputField(
                          controller: _devotionController,
                          label: 'Devotion Content',
                          hintText: 'Enter devotion content',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter devotion content';
                            }
                            return null;
                          },
                          maxLines: 6,
                        ),
                        const SizedBox(height: 20),

                        // Prayer
                        _buildInputField(
                          controller: _prayerController,
                          label: 'Prayer',
                          hintText: 'Enter a prayer',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a prayer';
                            }
                            return null;
                          },
                          maxLines: 4,
                        ),
                        const SizedBox(height: 32),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade600,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Create Devotion',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.indigo.shade400, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
