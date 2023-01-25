import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracking/constants/store.dart';
import 'package:timetracking/features/report/provider/report_provider.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/scroll_behavior.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReportProvider>(
      create: (context) => ReportProvider(),
      lazy: true,
      child: ScrollConfiguration(
        behavior: NoScrollGlowBehavior(),
        child: Consumer<ReportProvider>(
          key: const Key('Consumer'),
          builder: (context, provider, child) => ScaffoldWidget(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  provider.send();
                },
                child: const Icon(Icons.send_outlined)),
            body: ListviewWidget(
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ListviewBuilderWidget(
                      shrinkWrap: true,
                      itemCount: Store.items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var item = Store.items[index];
                        var select = item.title.hashCode ==
                            provider.reportItem.title.hashCode;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              provider.onChangeItem(item);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: select
                                        ? item.cColor!
                                        : Colors.transparent,
                                    width: 2),
                                color: item.color,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(item.iconData,
                                      size: 20, color: item.cColor!),
                                  Text(
                                    item.title,
                                    style: TextStyle(color: item.cColor!),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Form(
                      key: provider.formKey,
                      child: Column(
                        children: [
                          TextFiledWidget(
                            hintText: provider.reportItem.title,
                            onChanged: (s) {
                              provider.onInfoChanges(t: s);
                            },
                            mustValidate: true,
                          ),
                          TextFiledWidget(
                            maxLines: 10,
                            isMulti: true,
                            keyboardType: TextInputType.multiline,
                            hintText: provider.reportItem.body,
                            onChanged: (s) {
                              provider.onInfoChanges(b: s);
                            },
                            mustValidate: true,
                          ),
                        ],
                      )),
                ]),
          ),
        ),
      ),
    );
  }
}
