package fileItemToPart;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.Iterator;
import java.util.ArrayList;

import jakarta.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;

public class FileItemToPart implements Part {
    private FileItem fileItem;

    public FileItemToPart(Part part) {
        this.fileItem = new DiskFileItem(part.getName(), part.getContentType(), false, part.getName(), 0, null);
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return fileItem.getInputStream();
    }

    @Override
    public String getContentType() {
        return fileItem.getContentType();
    }

    @Override
    public String getName() {
        return fileItem.getName();
    }

    public String getSubmittedFileName() {
        return fileItem.getName();
    }

    @Override
    public long getSize() {
        return fileItem.getSize();
    }

    @Override
    public void write(String fileName) throws IOException {
        // 根據實際情況執行相應的操作
        // fileItem.write(new File(fileName));
    }

    @Override
    public void delete() throws IOException {
        // 根據實際情況執行相應的操作
    }

    @Override
    public String getHeader(String name) {
        return fileItem.getHeaders().getHeader(name);
    }

    @Override
    public Collection<String> getHeaders(String name) {
        Collection<String> headers = new ArrayList<>();
        Iterator<String> iterator = fileItem.getHeaders().getHeaders(name);
        while (iterator.hasNext()) {
            headers.add(iterator.next());
        }
        return headers;
    }

    @Override
    public Collection<String> getHeaderNames() {
        Iterator<String> iterator = fileItem.getHeaders().getHeaderNames();
        Collection<String> headerNames = new ArrayList<>();
        while (iterator.hasNext()) {
            headerNames.add(iterator.next());
        }
        return headerNames;
    }
}
