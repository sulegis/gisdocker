SuperMap GIS ϵ�в�Ʒ��Docker���񹹽��ű�

���
=======
## iExpress����

### ��������

1, ��iExpress�ļ��зŵ�Linuxϵͳ������~/iExpressλ��

2, ��iExpress�İ�Ҳ����~/iExpressλ�ã��޸�Dockerfile�ļ��е�iExpress������ʹһ��

3, ������������

```bash
$ sudo docker --tag supermap/iexpress build ~/iExpress
```

### �������iExpress��

�����������

```bash
$ sudo docker run --name iexpress1 -d -p 8090:8090 supermap/iexpress
```

���У�

* --name ����ʾ������Container���ƣ�����Ϊiexpress1
* -d����ʾ�������ں�̨����
* -p 8080:8090����������Container�ж˿�8090ӳ�䵽����������8090�˿�
	
��ˣ����� http://<������IP>:8090����ʼ���󣬼��ɿ���iExpress��ҳ

## iServer

ubuntu_public_deployiServer7C.sh ֱ�Ӵӹ���aliyun�洢��ȡiServer7C����װ

������iExpress����
