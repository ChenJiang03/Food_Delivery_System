function checkImageSize() {
    var input = document.getElementById('file');
    console.log(input.files.length);
    if (input.files && input.files[0]) {
        var file = input.files[0];
        var fileSize = file.size; // 文件大小（字节）
        console.log(fileSize);
        var maxSizeInBytes = 1048576; // 1MB（根据您的需求设置最大文件大小）

        if (fileSize > maxSizeInBytes) {
            alert('图片文件太大，图片最大不能超过1MB');
            // 这里可以根据需要进行其他处理，例如清空文件上传框的内容：
            input.value = '';
        }
    }
}