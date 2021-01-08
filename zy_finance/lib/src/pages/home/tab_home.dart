import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/model/transaksi.dart';
import 'package:zy_finance/src/model/user.dart';
import 'package:zy_finance/src/provider/transaksi_provider.dart';
import 'package:zy_finance/src/theme/box_decoration.dart';
import 'package:zy_finance/src/theme/text.dart';
import 'package:zy_finance/src/util/my_date_format.dart';
import 'package:zy_finance/src/widget/dialog.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransaksiProvider>(
          lazy: true,
          create: (_) => TransaksiProvider(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: Consumer<TransaksiProvider>(
          builder: (context, state, _) {
            return FloatingActionButton(
              onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                child: DialogTransaksi(title: 'Add Transaction'),
              ).then((value) => state.refreshData()),
              child: Icon(Icons.add),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Consumer<TransaksiProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return HomeDecor(
                        user: state.user,
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    (200 + (kToolbarHeight)),
                width: MediaQuery.of(context).size.width,
                child: Consumer<TransaksiProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.Loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 50),
                        physics: BouncingScrollPhysics(),
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          return ItemData(transaksi: state.result[index]);
                        },
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(child: Text(state.message));
                    } else if (state.state == ResultState.Error) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(''));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemData extends StatelessWidget {
  final Transaksi transaksi;

  ItemData({this.transaksi});

  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);
  final myFormat = MyDateFormat();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: transaksi.tipe == 'Income' ? iconIncome : iconSpend,
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(transaksi.namaTransaksi),
          Text(myFormat.myFullDateTime(DateTime.parse(transaksi.tanggal))),
        ],
      ),
      title: Text(
        f.format(transaksi.jumlah),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: transaksi.tipe == 'Income' ? Colors.green : Colors.red,
        ),
      ),
      onTap: () => showDialog(
        context: context,
        barrierDismissible: false,
        child: DetailTransaksi(transaksi: transaksi),
      ),
    );
  }
}

class HomeDecor extends StatelessWidget {
  final User user;

  HomeDecor({@required this.user});

  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user == null ? '' : user.nama,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        user == null ? '' : f.format(user.uang),
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

class DetailTransaksi extends StatelessWidget {
  final Transaksi transaksi;

  DetailTransaksi({@required this.transaksi});
  final f = NumberFormat.currency(name: 'Rp ', decimalDigits: 0);
  final myFormat = MyDateFormat();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Container(
        decoration: titleDialogDecor,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Detail Transaction',
            style: textWhite,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                f.format(transaksi.jumlah),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                        transaksi.tipe == 'Income' ? Colors.green : Colors.red),
              ),
              leading: transaksi.tipe == 'Income' ? iconIncome : iconSpend,
            ),
            ListTile(
              title: Text(transaksi.namaTransaksi),
              subtitle: Text('Judul'),
            ),
            ListTile(
              title: Text(
                  transaksi.keterangan == null ? '-' : transaksi.keterangan),
              subtitle: Text('Keterangan'),
            ),
            ListTile(
              title: Text(
                  myFormat.myFullDateTime(DateTime.parse(transaksi.tanggal))),
              subtitle: Text('Tanggal Transaksi'),
            ),
          ],
        ),
      ),
      actions: [
        RaisedButton(
          color: Colors.blueGrey,
          onPressed: () => Router.navigator.pop(),
          child: Text(
            'OK',
            style: textWhite,
          ),
        ),
      ],
    );
  }
}
