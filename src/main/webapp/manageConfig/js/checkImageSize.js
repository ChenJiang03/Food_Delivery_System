function checkImageSize() {
    var input = document.getElementById('file');
    console.log(input.files.length);
    if (input.files && input.files[0]) {
        var file = input.files[0];
        var fileSize = file.size; // �ļ���С���ֽڣ�
        console.log(fileSize);
        var maxSizeInBytes = 1048576; // 1MB����������������������ļ���С��

        if (fileSize > maxSizeInBytes) {
            alert('ͼƬ�ļ�̫��ͼƬ����ܳ���1MB');
            // ������Ը�����Ҫ��������������������ļ��ϴ�������ݣ�
            input.value = '';
        }
    }
}