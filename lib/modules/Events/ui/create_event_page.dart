import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/events/api/events_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventPage extends ConsumerStatefulWidget {
  const CreateEventPage({super.key});

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _date;
  bool _isCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // TODO: Handle image upload
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = _date ?? now;
    final minimumDate = now.subtract(const Duration(seconds: 1));
    DateTime? selectedDate = initialDate;

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      setState(() {
                        _date = selectedDate;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: initialDate.isBefore(minimumDate)
                      ? now
                      : initialDate,
                  minimumDate: minimumDate,
                  maximumDate: now.add(const Duration(days: 365)),
                  onDateTimeChanged: (DateTime newDate) {
                    selectedDate = newDate;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final weekday = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ][dateTime.weekday - 1];
    final month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][dateTime.month - 1];
    final hour = dateTime.hour == 0
        ? 12
        : dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$weekday, ${dateTime.day} $month ${dateTime.year} - $hour:$minute$period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  PressableScale(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.error.withCustomOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.close,
                          color: context.colors.error,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              PressableScale(
                child: GestureDetector(
                  onTap: _pickImage,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.error.withCustomOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow.withCustomOpacity(0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              PressableScale(
                child: GestureDetector(
                  onTap: _pickImage,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 56,
                    decoration: ShapeDecoration(
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: context.colors.error.withCustomOpacity(0.8),
                      shadows: [
                        BoxShadow(
                          color: context.colors.shadow.withCustomOpacity(0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add Background',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  color: context.colors.surface,
                  shadows: [
                    BoxShadow(
                      color: context.colors.shadow.withCustomOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter a short title',
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurface.withCustomOpacity(0.4),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  color: context.colors.surface,
                  shadows: [
                    BoxShadow(
                      color: context.colors.shadow.withCustomOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurface.withCustomOpacity(0.4),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PressableScale(
                child: GestureDetector(
                  onTap: _pickDate,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 64,
                    decoration: ShapeDecoration(
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: context.colors.surface,
                      shadows: [
                        BoxShadow(
                          color: context.colors.shadow.withCustomOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: context.colors.onSurface.withCustomOpacity(
                            0.6,
                          ),
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Date',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: context.colors.onSurface
                                      .withCustomOpacity(0.6),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatDateTime(_date ?? DateTime.now()),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: context.colors.onSurface.withCustomOpacity(
                            0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  color: context.colors.surface,
                  shadows: [
                    BoxShadow(
                      color: context.colors.shadow.withCustomOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurface.withCustomOpacity(0.4),
                    ),
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: context.colors.onSurface.withCustomOpacity(0.6),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                  ),
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PressableScale(
                child: GestureDetector(
                  onTap: _isCreating ? null : _createEvent,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 60,
                    decoration: ShapeDecoration(
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      color: _isCreating
                          ? context.colors.primary.withCustomOpacity(0.6)
                          : context.colors.primary,
                    ),
                    alignment: Alignment.center,
                    child: _isCreating
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                context.colors.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            'Create Event',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createEvent() async {
    // Validate inputs
    if (_titleController.text.trim().isEmpty) {
      ref.read(toastProvider).error(title: 'Error', text: 'Please enter a title');
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      ref.read(toastProvider).error(title: 'Error', text: 'Please enter a description');
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      final eventsApi = ref.read(eventsApiProvider);
      await eventsApi.createEvent(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: _date,
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
      );

      if (mounted) {
        // Show success message
        ref.read(toastProvider).success(title: 'Event created successfully!', text: 'Event created successfully!');
      }
    } catch (e) {
      ref.read(toastProvider).error(title: 'Error', text: 'Failed to create event: $e');
    } finally {
      setState(() {
        _isCreating = false;
      });
    }
  }
}
