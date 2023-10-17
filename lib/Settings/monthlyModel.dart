class MonthlyModel{
  final int expense;
  final int earning;
  const MonthlyModel({required this.earning, required this.expense});

  toJson(){
    return{
      "expense": expense,
      "earning": earning
    };
  }
}