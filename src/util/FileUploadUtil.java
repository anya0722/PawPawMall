package util;

import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

// Handle file upload process
public class FileUploadUtil {

    public static String saveFile(Part filePart, String uploadDirPath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Get the original file name
        String fileName = getFileName(filePart);
        // Generate a unique filename to prevent duplicating
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        
        filePart.write(uploadDirPath + File.separator + uniqueFileName);

        return "uploads/" + uniqueFileName;
    }

    private static String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "default.jpg";
    }
}
