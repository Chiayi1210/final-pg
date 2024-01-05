package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Multipartconfig")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 50      // 50 MB
)
public class Multipartconfig extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // 獲取所有上傳的部分
            Collection<Part> parts = request.getParts();

            for (Part part : parts) {
                // 假如部分的名稱為 "theFirstFile" 且大小大於 0
                if ("theFirstFile".equals(part.getName()) && part.getSize() > 0) {
                    // 獲取上傳的檔案名稱
                    String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    // 指定檔案上傳路徑為專案的 "uploads" 目錄下
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + fileName;

                    // 將檔案寫入指定路徑
                    part.write(uploadPath);

                    // 更新資料庫（這僅是示例，實際上應該使用連接池等更好的資料庫訪問方法）
                    // 註：應該根據實際的資料庫配置更改以下參數
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "username", "password");
                            Statement smt = con.createStatement()) {

                        // 更新資料庫中的檔案路徑
                        String updateQuery = "UPDATE your_table SET pic ='" + "uploads" + File.separator + fileName + "' WHERE id = 1";
                        int rowsUpdated = smt.executeUpdate(updateQuery);

                        // 根據更新的行數判斷是否成功
                        if (rowsUpdated > 0) {
                            out.println("檔案上傳並資料庫更新成功。");
                        } else {
                            out.println("資料庫更新失敗。");
                        }
                    } catch (Exception e) {
                        out.println("資料庫連線錯誤: " + e.getMessage());
                    }
                }
            }
        }
    }
}