import 'package:flutter/material.dart';

class SellerVerifyWidget extends StatefulWidget {
  final snap;

  const SellerVerifyWidget({Key? key, required this.snap}) : super(key: key);

  @override
  State<SellerVerifyWidget> createState() => _SellerVerifyWidgetState();
}

class _SellerVerifyWidgetState extends State<SellerVerifyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(Icons.electric_bike, color: Colors.black,),
              ),
              SizedBox(
                width: 18,
              ),
              Text(widget.snap['shopName'], style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),),
              SizedBox(
                width: 26,
              ),
              Align(
                alignment: Alignment.topRight,
                  child: Icon(Icons.verified_user, color:
                      widget.snap['isVerified']?
                  Colors.green:Colors.red,
                    size: 16,))
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(widget.snap['sellerName'], style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.normal),),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("${widget.snap['address']}\n${widget.snap['city']}, ${widget.snap['state']}, ${widget.snap['pinCode']}", style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.normal),),
        ),
        SizedBox(
          height: 12,
        ),
        Divider(color: Colors.grey.shade400, thickness: 0.5,)
      ],
    );
  }
}
