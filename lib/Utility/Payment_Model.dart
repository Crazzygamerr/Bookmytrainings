import 'dart:core';

class PaymentModel{

   String OrderId;
   String title;
   String date;
   String amount;
   String currency;
   String status;

   PaymentModel(this.OrderId, this.title, this.date, this.amount, this.currency, this.status);

}