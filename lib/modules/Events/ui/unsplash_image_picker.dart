import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_client/unsplash_client.dart';

class UnsplashImagePicker extends StatefulWidget {
  final String apiKey;

  const UnsplashImagePicker({super.key, required this.apiKey});

  @override
  State<UnsplashImagePicker> createState() => _UnsplashImagePickerState();
}

class _UnsplashImagePickerState extends State<UnsplashImagePicker> {
  late UnsplashClient _client;
  List<Photo> _photos = [];
  bool _isLoading = false;
  final _searchController = TextEditingController();
  String _lastQuery = 'Patterns';
  String? _selectedTheme;

  static const List<Map<String, dynamic>> _themeChips = [
    {'label': '🎃 Halloween', 'query': 'Halloween party decorations'},
    {'label': '🎄 Christmas', 'query': 'Christmas festive celebration'},
    {'label': '🎂 Birthday', 'query': 'Birthday party celebration'},
    {'label': '💍 Wedding', 'query': 'Wedding ceremony elegant'},
    {'label': '🎓 Graduation', 'query': 'Graduation celebration'},
    {'label': '🎉 Party', 'query': 'Party celebration fun'},
    {'label': '🌸 Spring', 'query': 'Spring flowers nature'},
    {'label': '☀️ Summer', 'query': 'Summer beach vacation'},
    {'label': '🍂 Autumn', 'query': 'Autumn fall colors'},
    {'label': '❄️ Winter', 'query': 'Winter snow landscape'},
  ];

  @override
  void initState() {
    super.initState();
    _client = UnsplashClient(
      settings: ClientSettings(credentials: AppCredentials(accessKey: widget.apiKey)),
    );
    _loadPhotos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _client.close();
    super.dispose();
  }

  Future<void> _loadPhotos() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final photos = await _client.photos.random(count: 20, query: _lastQuery).goAndGet();

      if (mounted) {
        setState(() {
          _photos = photos;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading images: $e')));
      }
    }
  }

  Future<void> _searchPhotos(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _lastQuery = query;
    });

    try {
      final photos = await _client.search.photos(query, perPage: 20).goAndGet();

      if (mounted) {
        setState(() {
          _photos = photos.results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error searching images: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.colors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        title: Text(
          'Choose Background',
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            color: context.colors.surface,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: ShapeDecoration(
                shape: RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: context.colors.background,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for images...',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurface.withCustomOpacity(0.4),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: context.colors.onSurface.withCustomOpacity(0.6),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: context.colors.onSurface.withCustomOpacity(0.6),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _selectedTheme = null;
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
                onSubmitted: (value) {
                  _searchPhotos(value);
                  setState(() {
                    _selectedTheme = null;
                  });
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          // Theme chips
          Container(
            height: 50,
            color: context.colors.surface,
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _themeChips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final theme = _themeChips[index];
                final isSelected = _selectedTheme == theme['label'];
                return PressableScale(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTheme = theme['label'] as String;
                      });
                      _searchPhotos(theme['query'] as String);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: ShapeDecoration(
                        shape: RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        color: isSelected
                            ? context.colors.primary
                            : context.colors.background,
                      ),
                      child: Center(
                        child: Text(
                          theme['label'] as String,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? context.colors.onPrimary
                                : context.colors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Photo grid
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: context.colors.primary))
                : _photos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_search,
                          size: 64,
                          color: context.colors.onBackground.withValues(alpha: 0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No images found',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colors.onBackground.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: _photos.length,
                    itemBuilder: (context, index) {
                      final photo = _photos[index];
                      return PressableScale(
                        child: GestureDetector(
                          onTap: () {
                            // Trigger download event as per Unsplash API guidelines
                            _client.photos.download(photo.id);
                            // Return the photo URL
                            Navigator.of(context).pop(photo.urls.regular.toString());
                          },
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedSuperellipseBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: context.colors.shadow.withCustomOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  photo.urls.small.toString(),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return ColoredBox(
                                      color: context.colors.surface,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                              : null,
                                          color: context.colors.primary,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return ColoredBox(
                                      color: context.colors.surface,
                                      child: Icon(Icons.error_outline, color: context.colors.error),
                                    );
                                  },
                                ),
                                // Attribution overlay
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.7),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      'by ${photo.user.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: context.colors.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by ',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  'Unsplash',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
