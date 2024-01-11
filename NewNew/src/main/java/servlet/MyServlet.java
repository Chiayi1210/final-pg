package servlet;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/Multipartconfig.java")
@MultipartConfig(
        location = "/tmp",
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,  // 5 MB
        maxRequestSize = 1024 * 1024 * 1024 * 5  // 25 MB
)
public class MyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // 獲取所有上傳的部分
            Collection<Part> parts = request.getParts();

            for (Part part : parts) {
                // 假如部分的名稱為 "theFirstFile" 且大小大於 0
                if ("pic".equals(part.getName()) && part.getSize() > 0) {
                    // 獲取上傳的檔案名稱
                    String fileName = getFileName(part);
                    // 指定檔案上傳路徑為專案的 "uploads" 目錄下
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + fileName;

                    // 將檔案寫入指定路徑
                    try (InputStream input = part.getInputStream()) {
                        Files.copy(input, Paths.get(uploadPath), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // 更新資料庫（這僅是示例，實際上應該使用連接池等更好的資料庫訪問方法）
                    // 註：應該根據實際的資料庫配置更改以下參數
                    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
                    try (Connection con = DriverManager.getConnection(" jdbc:ucanaccess://" + objDBConfig.FilePath(), "name", "pwd");
                            Statement smt = con.createStatement()) {

                        // 更新資料庫中的檔案路徑
                    	String updateQuery = "UPDATE member SET pic ='" + "uploads" + File.separator + fileName + "' WHERE id = 1";
                        int rowsUpdated = smt.executeUpdate(updateQuery);

                        // 根據更新的行數判斷是否成功
                        if (rowsUpdated > 0) {
                            response.getWriter().println("檔案上傳並資料庫更新成功。");
                        } else {
                            response.getWriter().println("資料庫更新失敗。");
                        }
                    } catch (Exception e) {
                        response.getWriter().println("資料庫連線錯誤: " + e.getMessage());
                    }
                }
            }
        } catch (IOException | ServletException | ClassNotFoundException e) {
            response.getWriter().println("發生錯誤: " + e.getMessage());
        }
    }

    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}