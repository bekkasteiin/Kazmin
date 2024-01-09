import 'package:flutter/material.dart';
import 'package:kzm/generated/l10n.dart';

class UpdateRequiedLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/brand_logo.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      S.of(context).updateIsRequired,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).updateT2crmnOldVersion,
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              MaterialButton(onPressed: (){},
              child: Text(S.of(context).update),),
              // RaisedButton(
              //   onPressed: () {},
              //   child: Text(S.of(context).update),
              // )
            ],
          ),
        ),
    );
  }
}
