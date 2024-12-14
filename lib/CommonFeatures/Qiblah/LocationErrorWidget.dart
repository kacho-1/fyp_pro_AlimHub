import 'package:flutter/material.dart';


class LocationErrorWidget extends StatelessWidget {

  const LocationErrorWidget({super.key,
  this.error,
  this.callback});
  final String? error;
  final Function? callback;

  @override
  Widget build(BuildContext context) {
    const errorColor = Colors.red;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.location_off,
            size : 150,
            color: errorColor,
          ),
          const SizedBox(height: 32,),
          Text(error!,
          style: const TextStyle(
            color: errorColor,
            fontWeight: FontWeight.bold
          ),),
          ElevatedButton(
              onPressed: (){
                if(callback !=null) callback!();
              },
              child: const Text('Retry')),

        ],
      ),
    );
  }
}
