import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/model/debit.dart';
import 'package:zy_finance/src/provider/debit_provider.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/text.dart';
import 'package:zy_finance/src/widget/dialog.dart';

class DebitTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DebitProvider>(
      create: (_) => DebitProvider(),
      lazy: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => myAnimationDialog(
            context,
            DialogDebit(title: 'Add Debt'),
          ),
          child: Icon(Icons.add),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerViewIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                pinned: false,
                floating: true,
                snap: true,
                elevation: 0,
                expandedHeight: 200,
                forceElevated: innerViewIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Consumer<DebitProvider>(
                    builder: (context, state, _) {
                      return Container(
                        decoration: flexSpaceDecor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.isDebt ? 'Debt' : 'In Debt',
                              style: titleAppStyle,
                            ),
                            SizedBox(height: 20),
                            Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10),
                                        Text(
                                          'Rp. ',
                                          style: moneyStyle,
                                        ),
                                        // user == null
                                        //     ? Text('0', style: moneyStyle)
                                        //     : Countup(
                                        //         begin: begin,
                                        //         end: end,
                                        //         duration:
                                        //             Duration(milliseconds: 500),
                                        //         separator: ',',
                                        //         style: moneyStyle,
                                        //       ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: Consumer<DebitProvider>(
              builder: (context, state, _) {
                if (state.state == DebtState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.state == DebtState.HasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      return ItemData(data: state.result[index]);
                    },
                  );
                } else if (state.state == DebtState.NoData) {
                  return Center(
                    child: Text(state.message, style: emptyStyle),
                  );
                } else if (state.state == DebtState.Error) {
                  return Center(
                    child: Text(state.message, style: emptyStyle),
                  );
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ItemData extends StatelessWidget {
  final Debt data;

  const ItemData({this.data});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
