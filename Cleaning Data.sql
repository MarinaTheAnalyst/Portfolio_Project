--Cleaning Data--

SELECT * FROM nashville;

SELECT * FROM nashville WHERE PropertyAddress is NULL;

UPDATE nashville SET PropertyAddress = "no address" WHERE PropertyAddress is NULL;

--SELECT * FROM nashville WHERE PropertyAddress = "no address";

--SELECT a.PropertyAddress, a.ParcelID, b.PropertyAddress, b.ParcelID FROM nashville as a JOIN nashville as b on a.ParcelID = b.ParcelID WHERE a.PropertyAddress = "no address";





SELECT PropertyAddress, ParcelID from nashville order by ParcelID;

SELECT PropertyAddress FROM nashville;

--SELECT substr(PropertyAddress, 1, instr(',', PropertyAddress) -1 ) as Address FROM nashville;

--SELECT substr (PropertyAddress, 1. 18) FROM nashville;

--SELECT instr (PropertyAddress, ',') FROM nashville;

--SELECT substr (PropertyAddress, 1, instr (PropertyAddress, ',') -1)as address	FROM nashville;


SELECT substr (PropertyAddress, 1, instr (PropertyAddress, ',') -1)as address, 
substr (PropertyAddress, instr (PropertyAddress, ',') +1, length(PropertyAddress))  as city 
FROM nashville;





--ALTER TABLE nashville ADD propertysplitaddress char(250);

UPDATE nashville set propertysplitaddress = substr (PropertyAddress, 1, instr (PropertyAddress, ',') -1);

--ALTER TABLE nashville ADD propertysplitcity char(250);

UPDATE nashville SET propertysplitcity = substr (PropertyAddress, instr (PropertyAddress, ',') +1, length(PropertyAddress));

SELECT * FROM nashville;





SELECT OwnerAddress FROM nashville;

SELECT substr (OwnerAddress, 1, instr (OwnerAddress, ',') -1)as address, 
substr(OwnerAddress, -2) as state FROM nashville;

--ALTER TABLE nashville ADD propertysplitstate char(250);

UPDATE nashville SET propertysplitstate = substr(OwnerAddress, -2);



---------------------------------------------------------------------------------------------------------------------------------------
---- Change Y and N to Yes and No in "Sold ad Vacant" Field
SELECT DISTINCT(SoldAsVacant),
 count (SoldAsVacant) FROM nashville 
 GROUP BY SoldAsVacant ORDER BY 2;

 
 SELECT SoldAsVacant , 
 CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
				WHEN SoldAsVacant = 'N' THEN 'NO'
				ELSE SoldAsVacant
				END
FROM nashville;
----------------------------------------------------------------------------------------------------------------------------------------------
----------REMOVE DUPLICATES


SELECT *, row_number ()
OVER (PARTITION BY ParcelID, 
PropertyAddress, SaleDate, SalePrice, LegalReference ORDER by UniqueID ) as row_num 
FROM nashville  ORDER by PropertyAddress ;

WITH CTE_rownum as 
(SELECT *, row_number ()
OVER (PARTITION BY ParcelID, 
PropertyAddress, SaleDate, SalePrice, LegalReference ORDER by UniqueID ) as row_num 
FROM nashville)

SELECT * FROM CTE_rownum where row_num > 1 order by PropertyAddress;


--------------------------------------------------------------------------------------------------
----- Delete unused columns

SELECT * from nashville;

ALTER TABLE nashville 
DROP COLUMN TaxDistrict, PropertyAddress, SaleDate
