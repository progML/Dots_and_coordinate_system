import javax.annotation.PostConstruct;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class AreaCheckServlet extends HttpServlet {
    private String X,Y,R,Result;
    private List<AreaCheckServlet> result;

    public AreaCheckServlet(){}

    final String resTrue = "Hit";
    final String resFalse = "Miss";


    @PostConstruct
    private void initializeBean(){
        result = new ArrayList<>();
    }

    public void addObjectToList(AreaCheckServlet acs){
        result.add(acs);
    }

    public String getX() {
        return X;
    }
    public void setX(String X) {
        this.X = X;
    }
    public String getY() {
        return Y;
    }
    public void setY(String Y) {
        this.Y = Y;
    }
    public String getR(){
        return R;
    }
    public void setR(String R){
        this.R = R;
    }
    public String getResult(){
        return Result;
    }
    public void setResult(String Result){
        this.Result = Result;
    }




    public boolean validate(String X, String Y, String R){
        double x = Double.parseDouble(X);
        double y = Double.parseDouble(Y);
        double r = Double.parseDouble(R);
        return ((x <= 0 && y >= 0 && (y <= ( x+(r/2))))) || (x >= 0 && y >= 0 && (Math.pow(x, 2) + Math.pow(y,
                2) <= Math.pow(r,2))) || (x >= 0 && y <= 0 && y >= (-r) && (x <= r/2));
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AreaCheckServlet acs = new AreaCheckServlet();
        PrintWriter out = response.getWriter();
        String X = request.getParameter("X");
        String Y = request.getParameter("Y");
        String R = request.getParameter("R");

        acs.setX(X);
        acs.setY(Y);
        acs.setR(R);


        if (acs.validate(X, Y, R)){
            acs.setResult(resTrue);
            //list.add(acs);
            addObjectToList(acs);
        } else {
            acs.setResult(resFalse);
            addObjectToList(acs);
        }

        out.println("<jsp:useBean id=\"result\" class=\"AreaCheckServlet\" scope=\"page\" />");

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Simple Session Tracker</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<table border: >");
        out.println("<tr> " +
                "<td><h3> X </h3></td>" +
                "<td><h3> Y </h3></td>" +
                "<td><h3> R </h3></td>" +
                "<td><h3> Answer </h3></td>" +
                "</tr>");

        for (AreaCheckServlet a:result) {
            out.println("<tr>");
            out.println("<td>" + a.getX() + "</td>");
            out.println("<td>" + a.getY() + "</td>");
            out.println("<td>" + a.getR() + "</td>");
            out.println("<td>" + a.getResult() + "</td>");
            out.println("</tr>");
        }
        out.println();
        out.println("</table>");
        out.println("</body>");
        out.println("</html>");
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        doGet(request,response);
    }
}
