import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

typedef OnSelectRow = void Function(int index, bool selected);

/// Ex of usage
/// SelectableRowGroup(
///   onSelect: (index, selected) => onSelect(snapshot.data![index]),
///   options: snapshot.data!
///       .map(
///         (e) => SelectableOption(
///           title: e.name,
///           subtitle: "Created on ${e.formattedCreationDate}",
///        ),
///       )
///       .toList(),
/// )
class OnboardingSelectableRowGroup extends StatefulWidget {
  final List<Widget> options;
  final List<Widget?>? onSelectInfoWidget;
  final OnSelectRow? onSelect;
  final int? initialSelectedIndex;
  final ScrollPhysics? physics;

  const OnboardingSelectableRowGroup({
    super.key,
    required this.options,
    this.onSelect,
    this.initialSelectedIndex,
    this.onSelectInfoWidget,
    this.physics,
  });

  @override
  State<OnboardingSelectableRowGroup> createState() =>
      _OnboardingSelectableRowGroupState();
}

class _OnboardingSelectableRowGroupState
    extends State<OnboardingSelectableRowGroup> {
  int? _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialSelectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: widget.physics,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final hasOnSelectInfo = widget.onSelectInfoWidget != null &&
            widget.onSelectInfoWidget!.length > index &&
            widget.onSelectInfoWidget![index] != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  if (_selectedIndex == index) {
                    return;
                  }
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onSelect?.call(index, true);
                },
                child: switch (hasOnSelectInfo && _selectedIndex == index) {
                  false => widget.options[index],
                  true => widget.options[index],
                },
              ),
            ),
            if (hasOnSelectInfo && _selectedIndex == index)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: widget.onSelectInfoWidget![index],
              ),
          ],
        );
      },
    );
  }
}

class OnboardingMultiSelectableRowGroup extends StatefulWidget {
  final List<SelectableOption> options;
  final OnSelectRow? onSelect;
  final ScrollPhysics? physics;
  // final int? initialSelectedIndex;

  const OnboardingMultiSelectableRowGroup({
    super.key,
    required this.options,
    this.onSelect,
    this.physics,
  });

  @override
  State<OnboardingMultiSelectableRowGroup> createState() =>
      _OnboardingMultiSelectableRowGroupState();
}

class _OnboardingMultiSelectableRowGroupState
    extends State<OnboardingMultiSelectableRowGroup> {
  final Set<int> _selectedIndex = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.options.map((option) {
        final index = widget.options.indexOf(option);
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            splashColor: context.colors.primary.withValues(alpha:.1),
            onTap: () {
              if (_selectedIndex.contains(index)) {
                _selectedIndex.remove(index);
                widget.onSelect?.call(index, false);
              } else {
                _selectedIndex.add(index);
                widget.onSelect?.call(index, true);
              }
              setState(() {});
            },
            child: SelectableRowTile(
              title: option.title,
              subtitle: option.subtitle,
              selected: _selectedIndex.contains(index),
              emoj: option.emoj,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class SelectableOption {
  final String title;
  final String? subtitle;
  final String? emoj;
  final bool selected;

  const SelectableOption({
    required this.title,
    this.subtitle,
    this.selected = false,
    this.emoj,
  });
}

/// Single row tile with a selectable radio box
class SelectableRowTile extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? emoj;
  final bool selected;
  final VoidCallback? onTap;

  const SelectableRowTile({
    super.key,
    this.title,
    this.subtitle,
    this.selected = false,
    this.onTap,
    this.emoj,
  });

  @override
  State<SelectableRowTile> createState() => _SelectableRowTileState();
}

class _SelectableRowTileState extends State<SelectableRowTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _iconSizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
    _iconSizeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    if (widget.selected) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SelectableRowTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected && widget.selected) {
      _controller.forward();
    } else if (oldWidget.selected != widget.selected && !widget.selected) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.selected //
              ? context.colors.primary.withValues(alpha:.6)
              : context.colors.primary.withValues(alpha:.1),
          width: widget.selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: widget.selected
            ? context.colors.primary.withValues(alpha:.3)
            : context.colors.surface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          if (widget.emoj != null)
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  widget.emoj!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (widget.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      widget.subtitle!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.grey2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!widget.selected)
            Flexible(
              flex: 0,
              child: RoundRadioBox.unselected(context),
            ),
          if (widget.selected)
            Flexible(
              flex: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return RoundRadioBox.selected(
                    context,
                    iconOpacity: _opacityAnimation.value,
                    iconSize: _iconSizeAnimation.value,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class RoundRadioBox extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final IconData? icon;
  final double iconOpacity;
  final double iconSize;

  const RoundRadioBox({
    super.key,
    required this.bgColor,
    required this.borderColor,
    this.iconOpacity = 1,
    this.iconSize = 1,
    this.icon,
  });

  factory RoundRadioBox.selected(
    BuildContext context, {
    double iconOpacity = 1,
    double iconSize = 1,
  }) {
    return RoundRadioBox(
      bgColor: context.colors.background.withValues(alpha:.3),
      borderColor: Colors.white.withValues(alpha:.3),
      icon: Icons.check,
      iconOpacity: iconOpacity,
      iconSize: iconSize,
    );
  }

  // ignore: avoid_unused_constructor_parameters
  factory RoundRadioBox.unselected(BuildContext context) {
    return RoundRadioBox(
      bgColor: context.colors.grey1,
      borderColor: context.colors.surface.withValues(alpha:.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 4,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Center(
        child: icon != null
            ? Opacity(
                opacity: iconOpacity,
                child: Transform.scale(
                  scale: iconSize,
                  child: Icon(
                    icon,
                    color: context.colors.grey2,
                    size: 21,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
