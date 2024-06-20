begin -- declare
	declare @Goods table(
		Id int identity(1,1) not null,
		Name nvarchar(256) not null,
		Price smallmoney not null,
		Count int not null
	);

	declare @�ategory table(
		Id int identity(1,1) not null,
		Name nvarchar(50) not null,
		SubCategoryId int
	);

	declare @GoodsCategory table(
		Id int identity(1,1) not null,
		CategoryId int,
		GoodsId int
	);
end

begin -- insert
	insert into @Goods(Name, Price, Count)
	values ('������� ������ ������ ���� ���������� ������� 70% 82�', 80, 28),
		   ('������� ������ ������ ���� �������� ���� � ������� 82�', 80, 35),
		   ('����� ������������ ������, ��������������, ����������������, 1�', 120, 99),
		   ('��� J7 ������������ � �������, 0,3 �', 64, 114),
		   ('�������� �������� ������������ 0,7 ��', 403, 12),
		   ('������� ������ �������� 90�', 90, 256),
		   ('WHISKAS ���� �/����� ����� ���� ��� 75�(����):28', 25, 512),
		   ('������', 0, 0);

	insert into @�ategory(Name, SubCategoryId)
	values ('���������� ������', null),
		   ('�������, �����', null),
		   ('����� � ����������', null),
		   ('�������', null),
		   ('���������', null),
		   ('������������ ��������', null),
		   ('�������', null);

	insert into @GoodsCategory(CategoryId, GoodsId)
	values (1, 1),
		   (1, 2),
		   (1, 6),
		   (2, 3),
		   (5, 7),
		   (6, 5),
		   (7, 4);
end

select 
	g.Name as '�����'
	,c.Name as '���������'
from @Goods as g
	left join(
		select 
			c.Name
			,gc.GoodsId
		from @�ategory as c
			left join(
				select 
					gc.CategoryId
					,gc.GoodsId
				from @GoodsCategory as gc
			) as gc on gc.CategoryId = c.Id
	) as c on c.GoodsId = g.Id
order by c.Name
	