use ypcrm

alter table producttype alter column parentid varchar(18)
alter table producttype alter column prodselfid varchar(18)
alter table producttype alter column prodtype varchar(20)

alter table product alter column prodselfid varchar(18)
alter table product alter column prodtype varchar(20)

--�޸Ĳ�Ʒ��

update product set prodselfid='11001',prodtype='������Ʒ��Ʒ' where prodselfid='116'

update product set prodselfid='11001001',prodtype='�칫�ľ���Ʒ' where prodselfid='1161'
update product set prodselfid='11001001001',prodtype='�ʼǱ�' where prodselfid='11615'
update product set prodselfid='11001001002',prodtype='�Ļ���Ʒ' where prodselfid='11613'

update product set prodselfid='11001002',prodtype='����ϵ����Ʒ' where prodselfid='11612'
update product set prodselfid='11001002001',prodtype='��ɰ��' where prodselfid='116102'
update product set prodselfid='11001002002',prodtype='�����' where prodselfid='11684'
update product set prodselfid='11001002003',prodtype='��汭' where prodselfid='11681'
update product set prodselfid='11001001004',prodtype='�˶�ˮ��' where prodselfid='11651'

update product set prodselfid='11001003',prodtype='���ӵ�����Ʒ' where prodselfid='1166'
update product set prodselfid='11001003001',prodtype='�����ֱ�' where prodselfid='11661'

update product set prodselfid='11001004',prodtype='������Ʒ' where prodselfid='11610'
update product set prodselfid='11001004001',prodtype='���' where prodselfid='116101'
update product set prodselfid='11001004002',prodtype='����' where prodselfid='116106'
update product set prodselfid='11001004003',prodtype='����' where prodselfid='116104'
update product set prodselfid='11001004004',prodtype='����' where prodselfid='116103'
update product set prodselfid='11001004005',prodtype='ˮ��������' where prodselfid='116105'

update product set prodselfid='11001005',prodtype='��������Ʒ' where prodselfid='1168'
update product set prodselfid='11001005001',prodtype='����' where prodselfid='11686'
update product set prodselfid='11001005002',prodtype='��Ͳ' where prodselfid='116816'
update product set prodselfid='11001005003',prodtype='����' where prodselfid='11687'
update product set prodselfid='11001005004',prodtype='���ڡ��ܽ��ҿ�' where prodselfid='116822'
update product set prodselfid='11001005005',prodtype='���ë��' where prodselfid='11689'
update product set prodselfid='11001005006',prodtype='���ñ' where prodselfid='11688'
update product set prodselfid='11001005007',prodtype='�����' where prodselfid='116813'
update product set prodselfid='11001005008',prodtype='��ͨ��' where prodselfid='116817'
update product set prodselfid='11001005009',prodtype='�մɱ�' where prodselfid='116811'
update product set prodselfid='11001005010',prodtype='���Ƿ�' where prodselfid='11682'
update product set prodselfid='11001005011',prodtype='����' where prodselfid='116821'
update product set prodselfid='11001005012',prodtype='Ƥ�ƿ�' where prodselfid='116810'
update product set prodselfid='11001005013',prodtype='�ֵ�Ͳ' where prodselfid='116815'
update product set prodselfid='11001005014',prodtype='����' where prodselfid='116814'
update product set prodselfid='11001005015',prodtype='̨��������������' where prodselfid='11683'
update product set prodselfid='11001005016',prodtype='�̻Ҹ�' where prodselfid='11685'
update product set prodselfid='11001005017',prodtype='ԡ���ɷ�ñ' where prodselfid='116820'
update product set prodselfid='11001005018',prodtype='�۵���' where prodselfid='116818'
update product set prodselfid='11001005019',prodtype='ֽ��' where prodselfid='116812'

update product set prodselfid='11001006',prodtype='�Ҿ�������Ʒ' where prodselfid='1167'
update product set prodselfid='11001006001',prodtype='���ʺ�' where prodselfid='11673'
update product set prodselfid='11001006002',prodtype='�;�' where prodselfid='11675'
update product set prodselfid='11001006003',prodtype='������Ʒ' where prodselfid='11671'
update product set prodselfid='11001006004',prodtype='ë�޹���' where prodselfid='11672'
update product set prodselfid='11001006005',prodtype='������װ' where prodselfid='11676'
update product set prodselfid='11001006006',prodtype='ֽ��Ͳ' where prodselfid='11674'

update product set prodselfid='11001007',prodtype='����������Ʒ' where prodselfid='1169'
update product set prodselfid='11001007001',prodtype='������' where prodselfid='11691'

update product set prodselfid='11001008',prodtype='Ƥ�������Ʒ' where prodselfid='11611'
update product set prodselfid='11001008001',prodtype='���԰�' where prodselfid='116111'
update product set prodselfid='11001008002',prodtype='��Ƭ����Ǯ����Կ�װ�' where prodselfid='116112'


update product set prodselfid='11001009',prodtype='������Ʒ' where prodselfid='11614'
update product set prodselfid='11001009001',prodtype='����' where prodselfid='116121'
update product set prodselfid='11001009002',prodtype='��ͷ�����' where prodselfid='116122'

update product set prodselfid='11001010',prodtype='�˶�������Ʒ' where prodselfid='1165'
update product set prodselfid='11001010001',prodtype='�߶�����Ʒ' where prodselfid='11652'
update product set prodselfid='11001010002',prodtype='����' where prodselfid='11653'
update product set prodselfid='11001010003',prodtype='������װ' where prodselfid='11654'

update product set prodselfid='11002',prodtype='�����ʲ�����' where prodselfid='118'

update product set prodselfid='11002001',prodtype='��ֵ�׺�Ʒ' where prodselfid='1181'
update product set prodselfid='11002002',prodtype='�̶��ʲ�' where prodselfid='1182'
update product set prodselfid='11002003',prodtype='֤������' where prodselfid='1183'

update product set prodselfid='11003',prodtype='һƷ�߻���Ŀ' where prodselfid='114'

update product set prodselfid='11003001',prodtype='��߻�' where prodselfid='1141'
update product set prodselfid='11003002',prodtype='�����������' where prodselfid='1142'
update product set prodselfid='11003003',prodtype='������Դ' where prodselfid='1143'
update product set prodselfid='11003004',prodtype='�����豸����' where prodselfid='1144'

update product set prodselfid='11004',prodtype='һƷ������Ŀ' where prodselfid='113'

update product set prodselfid='11004001',prodtype='���������' where prodselfid='1132'
update product set prodselfid='11004002',prodtype='�����������' where prodselfid='1133'
update product set prodselfid='11004003',prodtype='���������' where prodselfid='1131'
update product set prodselfid='11004004',prodtype='����װ������' where prodselfid='1135'
update product set prodselfid='11004005',prodtype='չʾչ����������' where prodselfid='1134'

update product set prodselfid='11005',prodtype='һƷý����Ŀ' where prodselfid='115'

update product set prodselfid='11005001',prodtype='��ֽ' where prodselfid='1154'
update product set prodselfid='11005002',prodtype='����̨' where prodselfid='1151'
update product set prodselfid='11005003',prodtype='��̨' where prodselfid='1152'
update product set prodselfid='11005004',prodtype='������' where prodselfid='1153'
update product set prodselfid='11005005',prodtype='������ý��' where prodselfid='1157'
update product set prodselfid='11005006',prodtype='����' where prodselfid='1156'
update product set prodselfid='11005007',prodtype='��־' where prodselfid='1155'

update product set prodselfid='11006',prodtype='һƷƽ����Ŀ' where prodselfid='112'

update product set prodselfid='11006001',prodtype='����' where prodselfid='1124'

update product set prodselfid='11006002',prodtype='���' where prodselfid='1121'
update product set prodselfid='11006002001',prodtype='VIϵͳ���' where prodselfid='11215'
update product set prodselfid='11006002002',prodtype='��Ʒ��װ���' where prodselfid='11214'
update product set prodselfid='11006002003',prodtype='��ƷĿ¼���' where prodselfid='11213'
update product set prodselfid='11006002004',prodtype='���ӻ������' where prodselfid='11216'
update product set prodselfid='11006002005',prodtype='�������' where prodselfid='11217'
update product set prodselfid='11006002006',prodtype='���󻭲����' where prodselfid='11212'

update product set prodselfid='11006003',prodtype='��Ӱ' where prodselfid='1123'

update product set prodselfid='11006004',prodtype='ӡˢ' where prodselfid='1122'
update product set prodselfid='11006004001',prodtype='����ӡˢ' where prodselfid='11223'
update product set prodselfid='11006004002',prodtype='���ź���ӡˢ' where prodselfid='11221'
update product set prodselfid='11006004003',prodtype='����ӡˢ' where prodselfid='11222'

update product set prodselfid='11007',prodtype='һƷ�ʲ�����' where prodselfid='117'
update product set prodselfid='11007001',prodtype='��ֵ�׺�Ʒ' where prodselfid='1171'
update product set prodselfid='11007002',prodtype='����' where prodselfid='1174'
update product set prodselfid='11007003',prodtype='�̶��ʲ�' where prodselfid='1173'
update product set prodselfid='11007004',prodtype='֤������' where prodselfid='1172'







--�޸Ĳ�Ʒ����
delete producttype where prodtyeid=196 or prodtyeid=59 or prodtyeid=175 or prodtyeid=176

update producttype set parentid='11',prodselfid='11001' where prodselfid='116'

update producttype set parentid='11001',prodselfid='11001001' where prodselfid='1161'
update producttype set parentid='11001001',prodselfid='11001001001' where prodselfid='11615'
update producttype set parentid='11001001',prodselfid='11001001002' where prodselfid='11613'

update producttype set parentid='11001',prodselfid='11001002' where prodselfid='11612'
update producttype set parentid='11001002',prodselfid='11001002001' where prodselfid='116102'
update producttype set parentid='11001002',prodselfid='11001002002' where prodselfid='11684'
update producttype set parentid='11001002',prodselfid='11001002003' where prodselfid='11681'
update producttype set parentid='11001002',prodselfid='11001001004' where prodselfid='11651'

update producttype set parentid='11001',prodselfid='11001003' where prodselfid='1166'
update producttype set parentid='11001003',prodselfid='11001003001' where prodselfid='11661'

update producttype set parentid='11001',prodselfid='11001004' where prodselfid='11610'
update producttype set parentid='11001004',prodselfid='11001004001' where prodselfid='116101'
update producttype set parentid='11001004',prodselfid='11001004002' where prodselfid='116106'
update producttype set parentid='11001004',prodselfid='11001004003' where prodselfid='116104'
update producttype set parentid='11001004',prodselfid='11001004004' where prodselfid='116103'
update producttype set parentid='11001004',prodselfid='11001004005' where prodselfid='116105'

update producttype set parentid='11001',prodselfid='11001005' where prodselfid='1168'
update producttype set parentid='11001005',prodselfid='11001005001' where prodselfid='11686'
update producttype set parentid='11001005',prodselfid='11001005002' where prodselfid='116816'
update producttype set parentid='11001005',prodselfid='11001005003' where prodselfid='11687'
update producttype set parentid='11001005',prodselfid='11001005004' where prodselfid='116822'
update producttype set parentid='11001005',prodselfid='11001005005' where prodselfid='11689'
update producttype set parentid='11001005',prodselfid='11001005006' where prodselfid='11688'
update producttype set parentid='11001005',prodselfid='11001005007' where prodselfid='116813'
update producttype set parentid='11001005',prodselfid='11001005008' where prodselfid='116817'
update producttype set parentid='11001005',prodselfid='11001005009' where prodselfid='116811'
update producttype set parentid='11001005',prodselfid='11001005010' where prodselfid='11682'
update producttype set parentid='11001005',prodselfid='11001005011' where prodselfid='116821'
update producttype set parentid='11001005',prodselfid='11001005012' where prodselfid='116810'
update producttype set parentid='11001005',prodselfid='11001005013' where prodselfid='116815'
update producttype set parentid='11001005',prodselfid='11001005014' where prodselfid='116814'
update producttype set parentid='11001005',prodselfid='11001005015' where prodselfid='11683'
update producttype set parentid='11001005',prodselfid='11001005016' where prodselfid='11685'
update producttype set parentid='11001005',prodselfid='11001005017' where prodselfid='116820'
update producttype set parentid='11001005',prodselfid='11001005018' where prodselfid='116818'
update producttype set parentid='11001005',prodselfid='11001005019' where prodselfid='116812'

update producttype set parentid='11001',prodselfid='11001006' where prodselfid='1167'
update producttype set parentid='11001006',prodselfid='11001006001' where prodselfid='11673'
update producttype set parentid='11001006',prodselfid='11001006002' where prodselfid='11675'
update producttype set parentid='11001006',prodselfid='11001006003' where prodselfid='11671'
update producttype set parentid='11001006',prodselfid='11001006004' where prodselfid='11672'
update producttype set parentid='11001006',prodselfid='11001006005' where prodselfid='11676'
update producttype set parentid='11001006',prodselfid='11001006006' where prodselfid='11674'

update producttype set parentid='11001',prodselfid='11001007' where prodselfid='1169'
update producttype set parentid='11001007',prodselfid='11001007001' where prodselfid='11691'

update producttype set parentid='11001',prodselfid='11001008' where prodselfid='11611'
update producttype set parentid='11001008',prodselfid='11001008001' where prodselfid='116111'
update producttype set parentid='11001008',prodselfid='11001008002' where prodselfid='116112'


update producttype set parentid='11001',prodselfid='11001009' where prodselfid='11614'
update producttype set parentid='11001009',prodselfid='11001009001' where prodselfid='116121'
update producttype set parentid='11001009',prodselfid='11001009002' where prodselfid='116122'

update producttype set parentid='11001',prodselfid='11001010' where prodselfid='1165'
update producttype set parentid='11001010',prodselfid='11001010001' where prodselfid='11652'
update producttype set parentid='11001010',prodselfid='11001010002' where prodselfid='11653'
update producttype set parentid='11001010',prodselfid='11001010003' where prodselfid='11654'

update producttype set parentid='11',prodselfid='11002' where prodselfid='118'

update producttype set parentid='11002',prodselfid='11002001' where prodselfid='1181'
update producttype set parentid='11002',prodselfid='11002002' where prodselfid='1182'
update producttype set parentid='11002',prodselfid='11002003' where prodselfid='1183'

update producttype set parentid='11',prodselfid='11003' where prodselfid='114'

update producttype set parentid='11003',prodselfid='11003001' where prodselfid='1141'
update producttype set parentid='11003',prodselfid='11003002' where prodselfid='1142'
update producttype set parentid='11003',prodselfid='11003003' where prodselfid='1143'
update producttype set parentid='11003',prodselfid='11003004' where prodselfid='1144'

update producttype set parentid='11',prodselfid='11004' where prodselfid='113'

update producttype set parentid='11004',prodselfid='11004001' where prodselfid='1132'
update producttype set parentid='11004',prodselfid='11004002' where prodselfid='1133'
update producttype set parentid='11004',prodselfid='11004003' where prodselfid='1131'
update producttype set parentid='11004',prodselfid='11004004' where prodselfid='1135'
update producttype set parentid='11004',prodselfid='11004005' where prodselfid='1134'

update producttype set parentid='11',prodselfid='11005' where prodselfid='115'

update producttype set parentid='11005',prodselfid='11005001' where prodselfid='1154'
update producttype set parentid='11005',prodselfid='11005002' where prodselfid='1151'
update producttype set parentid='11005',prodselfid='11005003' where prodselfid='1152'
update producttype set parentid='11005',prodselfid='11005004' where prodselfid='1153'
update producttype set parentid='11005',prodselfid='11005005' where prodselfid='1157'
update producttype set parentid='11005',prodselfid='11005006' where prodselfid='1156'
update producttype set parentid='11005',prodselfid='11005007' where prodselfid='1155'

update producttype set parentid='11',prodselfid='11006' where prodselfid='112'

update producttype set parentid='11006',prodselfid='11006001' where prodselfid='1124'

update producttype set parentid='11006',prodselfid='11006002' where prodselfid='1121'
update producttype set parentid='11006002',prodselfid='11006002001' where prodselfid='11215'
update producttype set parentid='11006002',prodselfid='11006002002' where prodselfid='11214'
update producttype set parentid='11006002',prodselfid='11006002003' where prodselfid='11213'
update producttype set parentid='11006002',prodselfid='11006002004' where prodselfid='11216'
update producttype set parentid='11006002',prodselfid='11006002005' where prodselfid='11217'
update producttype set parentid='11006002',prodselfid='11006002006' where prodselfid='11212'

update producttype set parentid='11006',prodselfid='11006003' where prodselfid='1123'

update producttype set parentid='11006',prodselfid='11006004' where prodselfid='1122'
update producttype set parentid='11006004',prodselfid='11006004001' where prodselfid='11223'
update producttype set parentid='11006004',prodselfid='11006004002' where prodselfid='11221'
update producttype set parentid='11006004',prodselfid='11006004003' where prodselfid='11222'

update producttype set parentid='11',prodselfid='11007' where prodselfid='117'
update producttype set parentid='11007',prodselfid='11007001' where prodselfid='1171'
update producttype set parentid='11007',prodselfid='11007002' where prodselfid='1174'
update producttype set parentid='11007',prodselfid='11007003' where prodselfid='1173'
update producttype set parentid='11007',prodselfid='11007004' where prodselfid='1172'