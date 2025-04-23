// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ui_modules/components/activity_notes/audio_player_widget.dart';
import 'package:flutter_ui_modules/components/search_bar/custom_search_bar.dart';
import 'package:flutter_ui_modules/shared/utils/constants/app_typography.dart';
import 'package:flutter_ui_modules/shared/utils/constants/app_colors.dart';



class ActivityNoteWidget extends StatelessWidget {

  final void Function(String query)? onSearch;
  final void Function()? onFilter;
  const ActivityNoteWidget({
    super.key, 
    required this.notes,
    this.onSearch,
    this.onFilter,
    this.title = "Activity Notes"
  });
  final List<ActivityNote> notes;
  final String title;

  @override
  Widget build(BuildContext context) {
    return _container(
        child: SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 24.0), 
            child: _noteItem(note),
          );
        },
      ),
    ));
  }

  Widget _container({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: AppTypographyy.textTheme.titleSmall?.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w800),
          ),
          CustomSearchBar(onChanged: onSearch, onFilterTap: onFilter,),
          child
        ],
      ),
    );
  }

  Widget _noteItem(ActivityNote note) {
    return IntrinsicHeight(
      // Adjusts the height of the row
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _leftItem(note),
          const SizedBox(width: 23),
          Expanded(
            child: _rightItem(note),
          ),
        ],
      ),
    );
  }

  Widget _rightItem(ActivityNote note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${note.title} - ",
              style: AppTypographyy.textTheme.titleSmall
                  ?.copyWith(color: AppColors.primary),
            ),
            Expanded(
              child: Text(
                note.subTitle,
                style: AppTypographyy.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkGrey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.maxFinite,
          color: AppColors.backgroundGrey,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                note.bodyBuilder,
                style: AppTypographyy.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.darkGrey),
              ),
              ...note.audioUrls.map((url) => AudioPlayerWidget(audioUrl: url))
            ],
          ),
        ),
      ],
    );
  }

  Widget _leftItem(ActivityNote note) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          note.icon,
          size: 24,
          color: AppColors.darkGrey,
        ),
        const SizedBox(height: 3), // Spacing between the icon and the line
        Expanded(
          child: Container(
            width: 1.0,
            color: AppColors.outlineVariant,
          ),
        ),
      ],
    );
  }
}

class ActivityNote {
  final String title;
  final String subTitle;
  final String bodyBuilder;
  final IconData icon;
  final List<String> audioUrls;

  ActivityNote(
      {required this.title,
      required this.subTitle,
      required this.bodyBuilder,
      required this.icon,
      this.audioUrls = const []});
}
