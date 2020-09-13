import 'dart:core';

class PaymentModel{

   String orderId;
   String title;
   String date;
   String amount;
   String currency;
   String status;

   PaymentModel(this.orderId, this.title, this.date, this.amount, this.currency, this.status);

}