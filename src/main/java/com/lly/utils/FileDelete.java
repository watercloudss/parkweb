package com.lly.utils;

import java.io.File;

public class FileDelete {
    public static void deleteFile(String filePath) {
        File file = new File(filePath);
        if (file.exists() && file.isFile()) {
            file.delete();
        }
    }
}
