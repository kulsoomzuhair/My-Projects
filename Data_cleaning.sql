 --SELECT * From [DTCleaning].[dbo].[Nashville Housing ]

--Where Property Address is null.

	/*Select a.ParcelID,  a.PropertyAddress, b.ParcelID, b.PropertyAddress , ISNULL(a.PropertyAddress,b.PropertyAddress)
	From [DTCleaning].[dbo].[Nashville Housing ]  a
	JOIN  [DTCleaning].[dbo].[Nashville Housing ] b
	 on a.ParcelID = b.ParcelID AND a.[UniqueID]<> b.[UniqueID]
	 Where a.PropertyAddress  is NULL

 --update null property address values

	 UPDATE  a SET PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
	From [DTCleaning].[dbo].[Nashville Housing ]  a
	JOIN  [DTCleaning].[dbo].[Nashville Housing ] b
	 on a.ParcelID = b.ParcelID AND a.[UniqueID]<> b.[UniqueID]
	 Where a.PropertyAddress  is NULL*/

 -- Breaking PropertyAddress into indivilual column(city, address, state)
	/* SELECT SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) AS address,
	 SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) AS address 
	 FROM [DTCleaning].[dbo].[Nashville Housing ]*/

  --Alter table add PropertyAddress column values

  /* Alter Table [DTCleaning].[dbo].[Nashville Housing ]
	 Add PropertySpliteAddress nvarChar(225)
	 Alter Table [DTCleaning].[dbo].[Nashville Housing ]
	 Add PropertySpliteCity nvarChar(225)
	*/

 /* Update [DTCleaning].[dbo].[Nashville Housing ]
  SET PropertySpliteAddress =SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1)  

  Update [DTCleaning].[dbo].[Nashville Housing ]
  SET PropertySpliteCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) */

  -- Breaking OwnerAddress into indivilual column(city, address, state)
 -- SELECT OwnerAddress From [DTCleaning].[dbo].[Nashville Housing ]
  /* Select PARSENAME(REPLACE(OwnerAddress,',','.'),3),
    PARSENAME(REPLACE(OwnerAddress,',','.'),2),
    PARSENAME(REPLACE(OwnerAddress,',','.'),1)
   From [DTCleaning].[dbo].[Nashville Housing ]*/

  --Alter table add ownerAddress column values
	/*Alter Table [DTCleaning].[dbo].[Nashville Housing ]
	 Add OwnerSpliteAddress nvarChar(225),
	  OwnerSpliteCity nvarChar(225),
	  OwnerSpliteState nvarChar(225)*/

	 /*
	Update [DTCleaning].[dbo].[Nashville Housing ]
		SET OwnerSpliteCity = PARSENAME(REPLACE(OwnerAddress,',','.'),3),
		OwnerSpliteAddress= PARSENAME(REPLACE(OwnerAddress,',','.'),2),
		OwnerSpliteState=   PARSENAME(REPLACE(OwnerAddress,',','.'),1)		
		From [DTCleaning].[dbo].[Nashville Housing ]
	*/
	
	--Change values from 1 & 0 to yes and no---

	/*
		Alter Table [DTCleaning].[dbo].[Nashville Housing ]
		ALTER COLUMN SoldAsVacant nvarChar(225)

		SELECT Distinct(SoldAsVacant),COUNT(SoldAsVacant)
		From [DTCleaning].[dbo].[Nashville Housing ]
		Group By SoldAsVacant
		Order By 2;
	*/
	
	/*
	Update [DTCleaning].[dbo].[Nashville Housing ]
		SET SoldAsVacant =	
			CASE
				when SoldAsVacant= 1 then  'YES'
				when SoldAsVacant= 0  then 'NO'
				ELSE SoldAsVacant 
			END
		From [DTCleaning].[dbo].[Nashville Housing ]
	*/
	
	--Remove Duplicate---
	/*
		with RowNumCTE As(
		Select *,
		ROW_NUMBER() Over(
		PARTITION BY 
					ParcelID,
					SaleDate,
					SalePrice,
					OwnerAddress,
					PropertyAddress,
					LegalReference
					ORDER BY
						UniqueID ) row_num
		From [DTCleaning].[dbo].[Nashville Housing ]
		)
		SELECT * From RowNumCTE
		Where row_num>1 order by PropertyAddress
	*/

	-- Drop unused column

    /*
		ALTER Table [DTCleaning].[dbo].[Nashville Housing ]
		Drop Column OwnerAddress, PropertyAddress,SaleDate,TaxDistric,SoldVacant;;
	*/

	SELECT * From [DTCleaning].[dbo].[Nashville Housing ]