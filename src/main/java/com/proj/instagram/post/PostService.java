package com.proj.instagram.post;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface PostService {
    int createPost(PostDTO postDTO, List<MultipartFile> files) throws Exception;
}
