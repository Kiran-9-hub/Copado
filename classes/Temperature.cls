public class Temperature {
    public static Decimal FtoC(Decimal Fh){
        Decimal result = (Fh-32)*5/9;
        return result.setScale(3);
    }
}