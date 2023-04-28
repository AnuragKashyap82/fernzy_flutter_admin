import 'package:flutter/material.dart';
import 'package:frenzy_admin/resources/firestore_methods.dart';

class SellerAccountVerification extends StatefulWidget {
  final snap;
  const SellerAccountVerification({Key? key, required this.snap}) : super(key: key);

  @override
  State<SellerAccountVerification> createState() =>
      _SellerAccountVerificationState();
}

class _SellerAccountVerificationState extends State<SellerAccountVerification> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seller Account Verificatoion",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Shop Name:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['shopName']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Seller Name:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['sellerName']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Seller Email:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['email']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Phone No:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['phoneNo']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Address:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['address']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "City:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['city']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pin Code:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['pinCode']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              ProofWidget(text:"Address Proof"),
              SizedBox(
                height: 26,
              ),
              Text(
                "Bank Details",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Account Holder Name:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['accountHolderName']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Account No:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['accountNo']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "GSTIN No:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "${widget.snap['gstNo']}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              ProofWidget(text:"Bank Passbook"),
              SizedBox(
                height: 26,
              ),
              SizedBox(
                height: 16,
              ),
              ProofWidget(text:"Signature"),
              SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(

        onPressed: (){
          _sellerVerificationDialog();
        },
        label: Text("Seller Verified"),
        icon: Icon(Icons.edit_note_outlined),
        backgroundColor: Colors.blue,
        elevation: 8,
      ),
    );
  }
  void _sellerVerificationDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding:
          EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(
                Icons.verified_user,
                color: Colors.blue,
              ),
              const Text("  Verification")
            ],
          ),
          content: Text(
            "Is  All the details Verified?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Reject",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
            MaterialButton(
              onPressed: () async {
                FireStoreMethods().verifySellerAccount(shopId: widget.snap['shopId']).then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Verified",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            )
          ],
        ));
  }
}

class ProofWidget extends StatefulWidget {
  final String text;
  const ProofWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ProofWidget> createState() => _ProofWidgetState();
}

class _ProofWidgetState extends State<ProofWidget> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 6,
      shadowColor: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.verified_user,
                    color: Colors.green,
                  )),
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 16, color: Colors.black87, letterSpacing: 0.5),
                  ),
                ),
                Container(
                  height: 350,
                  child: Center(
                      child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.grey.shade400,
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
