import 'package:budget/constants/app_colors.dart';
import 'package:budget/constants/design_system.dart';
import 'package:budget/enums/category_nature.dart';
import 'package:budget/enums/routes.dart';
import 'package:budget/models/category.dart';
import 'package:budget/services/category_service.dart';
import 'package:budget/utils/color.dart';
import 'package:budget/widgets/body_wrapper.dart';
import 'package:budget/widgets/j_alertbox.dart';
import 'package:budget/widgets/j_button.dart';
import 'package:budget/widgets/show_color_picker.dart';
import 'package:budget/widgets/j_dropdown.dart';
import 'package:budget/widgets/j_text_field.dart';
import 'package:budget/widgets/show_icon_picker.dart';
import 'package:budget/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _nameController = TextEditingController();
  String nature = CategoryNature.needs;
  Color _color = AppColor.secondaryColor;
  IconData? _iconData;
  Category? _category;

  void _gotoPreviousPage() {
    Navigator.popUntil(context, ModalRoute.withName(Routes.listCategory.name));
  }

  void Function()? saveCategory() {
    Category category = Category(
      name: _nameController.text,
      nature: nature,
      color: _color,
      iconData: _iconData ?? Icons.do_disturb,
      id: _category?.id,
    );

    CategoryService.saveCategory(category).then((value) {
      JSnack.show(context: context, message: 'Category added.');
      _gotoPreviousPage();
    });
  }

  void Function()? deleteCategory() {}

  @override
  void didChangeDependencies() {
    _category = ModalRoute.of(context)?.settings.arguments as Category?;
    _nameController.text = _category?.name ?? '';
    nature = _category?.nature ?? CategoryNature.needs;
    _iconData = _category?.iconData ?? Icons.do_disturb;
    _color = _category?.color ?? AppColor.secondaryColor;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add category"),
        actions: [
          IconButton(
            onPressed: () {
              JAlertBox.show(
                context,
                JAlertBox(
                  title: 'Delete Account?',
                  cancelPressed: () => Navigator.pop(context),
                  confirmPressed: () {
                    if (_category?.id != null) {
                      CategoryService.deleteCategory(_category!.id!).then((e) {
                        JSnack.show(
                            context: context, message: 'Category Deleted');
                        _gotoPreviousPage();
                      }).catchError((onError) {
                        JSnack.error(
                          context: context,
                          message: 'Cant delete category!. Try again.',
                        );
                      });
                    }
                  },
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Inset.l),
        child: JButton(
          text: _category != null ? "Update Category" : "Add Category",
          onPressed: saveCategory,
        ),
      ),
      body: BodyWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            JTextField(
              label: 'Name',
              controller: _nameController,
            ),
            JDropdownButton<String>(
              hint: 'Nature',
              value: nature,
              items: const [
                CategoryNature.needs,
                CategoryNature.savings,
                CategoryNature.wants,
              ],
              getChild: (String item) {
                return Text(item);
              },
              onChanged: (nature) {
                setState(() {
                  this.nature = nature ?? CategoryNature.needs;
                });
              },
            ),
            const SizedBox(
              height: Inset.l,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () =>
                        showIconPicker(context).then((IconData? value) {
                          if (value != null) {
                            setState(() {
                              _iconData = value;
                            });
                          }
                        }),
                    child: CircleAvatar(
                      child: Icon(
                        _iconData,
                        color: getAltColor(_color),
                      ),
                      backgroundColor: _color,
                    )),
                ActionChip(
                  onPressed: () {
                    showColorPicker(context, (Color color) {
                      setState(() {
                        _color = color;
                      });
                    });
                  },
                  label: Text(
                    'Select color',
                    style: TextStyle(color: getAltColor(_color)),
                  ),
                  backgroundColor: _color,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
