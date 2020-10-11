import 'package:Blockpay/ss2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';

int myAmount = 0;

class web extends StatefulWidget {
  @override
  _webState createState() => _webState();
}

class _webState extends State<web> {
  Client httpcl;
  Web3Client ethcl;
  bool data = false;
  final address = "0x197b4a6ECf9aE7Bb5593417A10ee645b2d9EFAa0";

  var myData;
  @override
  void initState() {
    httpcl = new Client();
    ethcl = new Web3Client(
        "https://rinkeby.infura.io/v3/a2f17d56226d46a5b0c2975adcf34c8b",
        httpcl);

    super.initState();
    getBalance(address);
  }

  Future<DeployedContract> loadcontract() async {
    String abi = await rootBundle.loadString('lib/Assets/abi.json');
    String contractaddr = "0xd71cbAba1D3b61fbfa3c1ED0216200A8c739A752";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "PKCoin"),
        EthereumAddress.fromHex(contractaddr));
    return contract;
  }

  Future<List<dynamic>> query(String fname, List<dynamic> args) async {
    final contract = await loadcontract();
    final ethf = contract.function(fname);
    final result =
        await ethcl.call(contract: contract, function: ethf, params: args);
    return result;
  }

  Future<void> getBalance(String taddr) async {
    EthereumAddress address = EthereumAddress.fromHex(taddr);
    List<dynamic> result = await query("getBalance", []);
    myData = result[0];
    data = true;
    setState(() {});
  }

  Future<String> sendcoin() async {
    var bigamount = BigInt.from(myAmount);
    var response = await submit("getDeposit", [bigamount]);
    print('Deposited');
    return response;
  }

  Future<String> withdrawcoin() async {
    var bigamount = BigInt.from(myAmount);
    var response = await submit("withdrawBalance", [bigamount]);
    print('withdrawn');
    return response;
  }

  Future<String> submit(String fname, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "93859e0e29a05bdf42f31661a59b6534ba3c00694d5987805238caef65eab99f");
    DeployedContract contract = await loadcontract();
    final ethf = contract.function(fname);
    final result = await ethcl.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethf, parameters: args),
        fetchChainIdFromNetworkId: true);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      body: ZStack([
        VxBox()
            .blue600
            .size(context.screenWidth, context.percentHeight * 30)
            .make(),
        VStack([
          (context.percentHeight * 10).heightBox,
          "\u{20B9}BlockPay".text.xl4.white.bold.center.makeCentered().py16(),
          (context.percentHeight * 5).heightBox,
          VxBox(
                  child: VStack([
            "Balance".text.gray700.xl2.semiBold.makeCentered(),
            10.heightBox,
            data
                ? "\u{20B9}$myData".text.bold.xl6.makeCentered().shimmer()
                : CircularProgressIndicator().centered()
          ]))
              .p16
              .white
              .size(context.screenWidth, context.percentHeight * 18)
              .rounded
              .shadowXl
              .make()
              .p16(),
          30.heightBox,
          SliderWidget(
            max: 100,
            min: 0,
          ).centered(),
          HStack(
            [
              FlatButton.icon(
                      onPressed: () => getBalance(address),
                      color: Colors.blue,
                      shape: Vx.roundedSm,
                      icon: Icon(Icons.refresh),
                      label: "Refresh".text.white.bold.make())
                  .h(50),
              FlatButton.icon(
                      onPressed: () => sendcoin(),
                      color: Colors.green,
                      shape: Vx.roundedSm,
                      icon: Icon(Icons.call_made_outlined),
                      label: "Deposit".text.white.bold.make())
                  .h(50),
              FlatButton.icon(
                      onPressed: () => withdrawcoin(),
                      color: Colors.red,
                      shape: Vx.roundedSm,
                      icon: Icon(Icons.call_received_outlined),
                      label: "Withdraw".text.white.bold.make())
                  .h(50)
            ],
            alignment: MainAxisAlignment.spaceAround,
            axisSize: MainAxisSize.max,
          ).p16()
        ])
      ]),
    );
  }
}

class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final ValueChanged<double> finalval;

  SliderWidget(
      {this.sliderHeight = 48,
      this.max = 100,
      this.min = 0,
      this.fullWidth = false,
      this.finalval});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF00c6ff),
              const Color(0xFF0072ff),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),

                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(thumbRadius: 15.0),
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                      min: 0,
                      max: 100,
                      value: myAmount.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          myAmount = value.round();
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
