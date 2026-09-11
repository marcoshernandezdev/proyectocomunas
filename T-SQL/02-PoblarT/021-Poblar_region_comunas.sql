USE ProyectoComunas;
GO
    TRUNCATE TABLE dbo.Comuna;
GO    
    Delete from dbo.Region;
    DBCC CHECKIDENT ('dbo.Region', RESEED, 0);
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO
BEGIN TRY
    BEGIN TRANSACTION;

    IF OBJECT_ID(N'dbo.Region', N'U') IS NULL OR OBJECT_ID(N'dbo.Comuna', N'U') IS NULL
        THROW 51000, 'Primero debe crear las tablas dbo.Region y dbo.Comuna.', 1;
        
    DECLARE @Regiones TABLE
    (
        Id [int] IDENTITY(1,1) NOT NULL,
        CodigoRegion VARCHAR(5) NOT NULL PRIMARY KEY,
        NombreRegion NVARCHAR(128) NOT NULL UNIQUE
    );

    INSERT INTO @Regiones (CodigoRegion, NombreRegion)
    VALUES       
        ('I', N'Tarapacá'),
        ('II', N'Antofagasta'),
        ('III', N'Atacama'),
        ('IV', N'Coquimbo'),
        ('V', N'Valparaíso'),        
        ('VI', N'O''Higgins'),
        ('VII', N'Maule'),       
        ('VIII', N'Biobío'),
        ('IX', N'La Araucanía'),        
        ('X', N'Los Lagos'),
        ('XI', N'Aysén'),
        ('XII', N'Magallanes'),
        ('RM', N'Metropolitana'),
        ('XIV', N'Los Ríos'),
        ('XV', N'Arica y Parinacota'),
        ('XVI', N'Ñuble');

    Insert into dbo.Region (NombreRegion)
    select R.NombreRegion
    from @Regiones as R
    order by R.Id
  
    DECLARE @Comunas TABLE
    (
        CodigoRegion VARCHAR(5) NOT NULL,
        NombreComuna NVARCHAR(128) NOT NULL,
        InformacionAdicional XML NOT NULL,
        PRIMARY KEY (CodigoRegion, NombreComuna)
    );

    INSERT INTO @Comunas (CodigoRegion, NombreComuna, InformacionAdicional)
    VALUES
        ('XV', N'Arica', CONVERT(XML, N'<Info><Superficie>4799.4</Superficie><Poblacion Densidad="51.6">241653</Poblacion></Info>')),
        ('XV', N'Camarones', CONVERT(XML, N'<Info><Superficie>3927</Superficie><Poblacion Densidad="0.31">861</Poblacion></Info>')),
        ('XV', N'Putre', CONVERT(XML, N'<Info><Superficie>5902.5</Superficie><Poblacion Densidad="0.43">1547</Poblacion></Info>')),
        ('XV', N'General Lagos', CONVERT(XML, N'<Info><Superficie>2244.4</Superficie><Poblacion Densidad="0.36">508</Poblacion></Info>')),
        ('I', N'Iquique', CONVERT(XML, N'<Info><Superficie>2242.1</Superficie><Poblacion Densidad="996">199587</Poblacion></Info>')),
        ('I', N'Alto Hospicio', CONVERT(XML, N'<Info><Superficie>572.9</Superficie><Poblacion Densidad="2268">142086</Poblacion></Info>')),
        ('I', N'Pozo Almonte', CONVERT(XML, N'<Info><Superficie>13765.8</Superficie><Poblacion Densidad="1.26">16878</Poblacion></Info>')),
        ('I', N'Camiña', CONVERT(XML, N'<Info><Superficie>2200.2</Superficie><Poblacion Densidad="0.62">1335</Poblacion></Info>')),
        ('I', N'Colchane', CONVERT(XML, N'<Info><Superficie>4015.6</Superficie><Poblacion Densidad="0.39">790</Poblacion></Info>')),
        ('I', N'Huara', CONVERT(XML, N'<Info><Superficie>10474.6</Superficie><Poblacion Densidad="0.29">2858</Poblacion></Info>')),
        ('I', N'Pica', CONVERT(XML, N'<Info><Superficie>8934.3</Superficie><Poblacion Densidad="66">6272</Poblacion></Info>')),
        ('II', N'Antofagasta', CONVERT(XML, N'<Info><Superficie>30718.1</Superficie><Poblacion Densidad="13.8">401096</Poblacion></Info>')),
        ('II', N'Mejillones', CONVERT(XML, N'<Info><Superficie>3803.9</Superficie><Poblacion Densidad="3.88">14084</Poblacion></Info>')),
        ('II', N'Sierra Gorda', CONVERT(XML, N'<Info><Superficie>12886</Superficie><Poblacion Densidad="0.14">1472</Poblacion></Info>')),
        ('II', N'Taltal', CONVERT(XML, N'<Info><Superficie>20405.1</Superficie><Poblacion Densidad="0.67">12097</Poblacion></Info>')),
        ('II', N'Calama', CONVERT(XML, N'<Info><Superficie>15596.9</Superficie><Poblacion Densidad="12.2">166334</Poblacion></Info>')),
        ('II', N'Ollagüe', CONVERT(XML, N'<Info><Superficie>2964</Superficie><Poblacion Densidad="0.09">256</Poblacion></Info>')),
        ('II', N'San Pedro de Atacama', CONVERT(XML, N'<Info><Superficie>23439</Superficie><Poblacion Densidad="0.45">9843</Poblacion></Info>')),
        ('II', N'Tocopilla', CONVERT(XML, N'<Info><Superficie>4038.8</Superficie><Poblacion Densidad="6.95">25400</Poblacion></Info>')),
        ('II', N'María Elena', CONVERT(XML, N'<Info><Superficie>12197</Superficie><Poblacion Densidad="0.55">4834</Poblacion></Info>')),
        ('III', N'Copiapó', CONVERT(XML, N'<Info><Superficie>16681.3</Superficie><Poblacion Densidad="10.2">168831</Poblacion></Info>')),
        ('III', N'Caldera', CONVERT(XML, N'<Info><Superficie>4666.6</Superficie><Poblacion Densidad="4.16">18805</Poblacion></Info>')),
        ('III', N'Tierra Amarilla', CONVERT(XML, N'<Info><Superficie>11191</Superficie><Poblacion Densidad="1.27">11846</Poblacion></Info>')),
        ('III', N'Chañaral', CONVERT(XML, N'<Info><Superficie>5772</Superficie><Poblacion Densidad="2.28">12345</Poblacion></Info>')),
        ('III', N'Diego de Almagro', CONVERT(XML, N'<Info><Superficie>18664</Superficie><Poblacion Densidad="0.77">11397</Poblacion></Info>')),
        ('III', N'Vallenar', CONVERT(XML, N'<Info><Superficie>7084</Superficie><Poblacion Densidad="8.04">54222</Poblacion></Info>')),
        ('III', N'Alto del Carmen', CONVERT(XML, N'<Info><Superficie>5939</Superficie><Poblacion Densidad="0.96">4788</Poblacion></Info>')),
        ('III', N'Freirina', CONVERT(XML, N'<Info><Superficie>3207.9</Superficie><Poblacion Densidad="2.39">7577</Poblacion></Info>')),
        ('III', N'Huasco', CONVERT(XML, N'<Info><Superficie>1601.4</Superficie><Poblacion Densidad="7.03">9369</Poblacion></Info>')),
        ('IV', N'La Serena', CONVERT(XML, N'<Info><Superficie>1892.8</Superficie><Poblacion Densidad="131.8">250141</Poblacion></Info>')),
        ('IV', N'Coquimbo', CONVERT(XML, N'<Info><Superficie>1429</Superficie><Poblacion Densidad="179.6">263719</Poblacion></Info>')),
        ('IV', N'Andacollo', CONVERT(XML, N'<Info><Superficie>310</Superficie><Poblacion Densidad="38">11566</Poblacion></Info>')),
        ('IV', N'La Higuera', CONVERT(XML, N'<Info><Superficie>4158.2</Superficie><Poblacion Densidad="1.07">4335</Poblacion></Info>')),
        ('IV', N'Paihuano', CONVERT(XML, N'<Info><Superficie>1495</Superficie><Poblacion Densidad="3.12">4649</Poblacion></Info>')),
        ('IV', N'Vicuña', CONVERT(XML, N'<Info><Superficie>7610</Superficie><Poblacion Densidad="3.9">28047</Poblacion></Info>')),
        ('IV', N'Illapel', CONVERT(XML, N'<Info><Superficie>2629</Superficie><Poblacion Densidad="12.4">32009</Poblacion></Info>')),
        ('IV', N'Canela', CONVERT(XML, N'<Info><Superficie>2196.6</Superficie><Poblacion Densidad="4.34">9639</Poblacion></Info>')),
        ('IV', N'Los Vilos', CONVERT(XML, N'<Info><Superficie>1823.8</Superficie><Poblacion Densidad="12.8">22879</Poblacion></Info>')),
        ('IV', N'Salamanca', CONVERT(XML, N'<Info><Superficie>3445</Superficie><Poblacion Densidad="8.44">27823</Poblacion></Info>')),
        ('IV', N'Ovalle', CONVERT(XML, N'<Info><Superficie>3835</Superficie><Poblacion Densidad="31.6">118696</Poblacion></Info>')),
        ('IV', N'Combarbalá', CONVERT(XML, N'<Info><Superficie>2257.5</Superficie><Poblacion Densidad="6.14">12954</Poblacion></Info>')),
        ('IV', N'Monte Patria', CONVERT(XML, N'<Info><Superficie>4366.9</Superficie><Poblacion Densidad="7.44">29997</Poblacion></Info>')),
        ('IV', N'Punitaqui', CONVERT(XML, N'<Info><Superficie>1339</Superficie><Poblacion Densidad="9.08">12076</Poblacion></Info>')),
        ('IV', N'Río Hurtado', CONVERT(XML, N'<Info><Superficie>2180</Superficie><Poblacion Densidad="2.01">4334</Poblacion></Info>')),
        ('V', N'Valparaíso', CONVERT(XML, N'<Info><Superficie>401.6</Superficie><Poblacion Densidad="810.2">284938</Poblacion></Info>')),
        ('V', N'Casablanca', CONVERT(XML, N'<Info><Superficie>953</Superficie><Poblacion Densidad="30.6">29876</Poblacion></Info>')),
        ('V', N'Concón', CONVERT(XML, N'<Info><Superficie>76</Superficie><Poblacion Densidad="603.8">48294</Poblacion></Info>')),
        ('V', N'Juan Fernández', CONVERT(XML, N'<Info><Superficie>149.4</Superficie><Poblacion Densidad="6.93">904</Poblacion></Info>')),
        ('V', N'Puchuncaví', CONVERT(XML, N'<Info><Superficie>300</Superficie><Poblacion Densidad="66.9">22539</Poblacion></Info>')),
        ('V', N'Quintero', CONVERT(XML, N'<Info><Superficie>148</Superficie><Poblacion Densidad="244.1">35754</Poblacion></Info>')),
        ('V', N'Viña del Mar', CONVERT(XML, N'<Info><Superficie>121.6</Superficie><Poblacion Densidad="2962">334871</Poblacion></Info>')),
        ('V', N'Isla de Pascua', CONVERT(XML, N'<Info><Superficie>163.6</Superficie><Poblacion Densidad="50.4">4800</Poblacion></Info>')),
        ('V', N'Los Andes', CONVERT(XML, N'<Info><Superficie>1248</Superficie><Poblacion Densidad="54.5">63440</Poblacion></Info>')),
        ('V', N'Calle Larga', CONVERT(XML, N'<Info><Superficie>321.7</Superficie><Poblacion Densidad="51.1">16597</Poblacion></Info>')),
        ('V', N'Rinconada', CONVERT(XML, N'<Info><Superficie>122.5</Superficie><Poblacion Densidad="91.5">11855</Poblacion></Info>')),
        ('V', N'San Esteban', CONVERT(XML, N'<Info><Superficie>1361.6</Superficie><Poblacion Densidad="30.3">20112</Poblacion></Info>')),
        ('V', N'La Ligua', CONVERT(XML, N'<Info><Superficie>1163</Superficie><Poblacion Densidad="32.4">39270</Poblacion></Info>')),
        ('V', N'Cabildo', CONVERT(XML, N'<Info><Superficie>1455</Superficie><Poblacion Densidad="14.2">20015</Poblacion></Info>')),
        ('V', N'Papudo', CONVERT(XML, N'<Info><Superficie>64.3</Superficie><Poblacion Densidad="96.8">7561</Poblacion></Info>')),
        ('V', N'Petorca', CONVERT(XML, N'<Info><Superficie>1517</Superficie><Poblacion Densidad="6.95">10206</Poblacion></Info>')),
        ('V', N'Zapallar', CONVERT(XML, N'<Info><Superficie>288</Superficie><Poblacion Densidad="27.7">7980</Poblacion></Info>')),
        ('V', N'Quillota', CONVERT(XML, N'<Info><Superficie>302</Superficie><Poblacion Densidad="323">96753</Poblacion></Info>')),
        ('V', N'La Calera', CONVERT(XML, N'<Info><Superficie>60.5</Superficie><Poblacion Densidad="878.5">50631</Poblacion></Info>')),
        ('V', N'Hijuelas', CONVERT(XML, N'<Info><Superficie>267</Superficie><Poblacion Densidad="71.5">19286</Poblacion></Info>')),
        ('V', N'La Cruz', CONVERT(XML, N'<Info><Superficie>78</Superficie><Poblacion Densidad="324.6">24939</Poblacion></Info>')),
        ('V', N'Nogales', CONVERT(XML, N'<Info><Superficie>405</Superficie><Poblacion Densidad="58">22136</Poblacion></Info>')),
        ('V', N'San Antonio', CONVERT(XML, N'<Info><Superficie>405</Superficie><Poblacion Densidad="238.9">96770</Poblacion></Info>')),
        ('V', N'Algarrobo', CONVERT(XML, N'<Info><Superficie>1760</Superficie><Poblacion Densidad="86.2">16076</Poblacion></Info>')),
        ('V', N'Cartagena', CONVERT(XML, N'<Info><Superficie>246</Superficie><Poblacion Densidad="103">24599</Poblacion></Info>')),
        ('V', N'El Quisco', CONVERT(XML, N'<Info><Superficie>51</Superficie><Poblacion Densidad="347.8">18971</Poblacion></Info>')),
        ('V', N'El Tabo', CONVERT(XML, N'<Info><Superficie>99</Superficie><Poblacion Densidad="144.8">16260</Poblacion></Info>')),
        ('V', N'Santo Domingo', CONVERT(XML, N'<Info><Superficie>536</Superficie><Poblacion Densidad="22.2">13171</Poblacion></Info>')),
        ('V', N'San Felipe', CONVERT(XML, N'<Info><Superficie>186</Superficie><Poblacion Densidad="448.8">80413</Poblacion></Info>')),
        ('V', N'Catemu', CONVERT(XML, N'<Info><Superficie>361.6</Superficie><Poblacion Densidad="42">13760</Poblacion></Info>')),
        ('V', N'Llay-Llay', CONVERT(XML, N'<Info><Superficie>349.1</Superficie><Poblacion Densidad="76">24484</Poblacion></Info>')),
        ('V', N'Panquehue', CONVERT(XML, N'<Info><Superficie>121.9</Superficie><Poblacion Densidad="62.5">7269</Poblacion></Info>')),
        ('V', N'Putaendo', CONVERT(XML, N'<Info><Superficie>1474</Superficie><Poblacion Densidad="11.9">17336</Poblacion></Info>')),
        ('V', N'Santa María', CONVERT(XML, N'<Info><Superficie>166.3</Superficie><Poblacion Densidad="98.5">15134</Poblacion></Info>')),
        ('V', N'Quilpué', CONVERT(XML, N'<Info><Superficie>536.9</Superficie><Poblacion Densidad="311.1">162559</Poblacion></Info>')),
        ('V', N'Limache', CONVERT(XML, N'<Info><Superficie>294</Superficie><Poblacion Densidad="169.8">56145</Poblacion></Info>')),
        ('V', N'Olmué', CONVERT(XML, N'<Info><Superficie>232</Superficie><Poblacion Densidad="83">19778</Poblacion></Info>')),
        ('V', N'Villa Alemana', CONVERT(XML, N'<Info><Superficie>97</Superficie><Poblacion Densidad="1436.1">139571</Poblacion></Info>')),
        ('VI', N'Rancagua', CONVERT(XML, N'<Info><Superficie>260.3</Superficie><Poblacion Densidad="1020">265211</Poblacion></Info>')),
        ('VI', N'Codegua', CONVERT(XML, N'<Info><Superficie>287</Superficie><Poblacion Densidad="49.1">14096</Poblacion></Info>')),
        ('VI', N'Coinco', CONVERT(XML, N'<Info><Superficie>98</Superficie><Poblacion Densidad="79.9">7831</Poblacion></Info>')),
        ('VI', N'Coltauco', CONVERT(XML, N'<Info><Superficie>225</Superficie><Poblacion Densidad="94.5">21263</Poblacion></Info>')),
        ('VI', N'Doñihue', CONVERT(XML, N'<Info><Superficie>78</Superficie><Poblacion Densidad="291">22700</Poblacion></Info>')),
        ('VI', N'Graneros', CONVERT(XML, N'<Info><Superficie>113</Superficie><Poblacion Densidad="323">36504</Poblacion></Info>')),
        ('VI', N'Las Cabras', CONVERT(XML, N'<Info><Superficie>749</Superficie><Poblacion Densidad="35.7">26740</Poblacion></Info>')),
        ('VI', N'Machalí', CONVERT(XML, N'<Info><Superficie>2597</Superficie><Poblacion Densidad="23.1">59913</Poblacion></Info>')),
        ('VI', N'Malloa', CONVERT(XML, N'<Info><Superficie>113</Superficie><Poblacion Densidad="125.3">14163</Poblacion></Info>')),
        ('VI', N'Mostazal', CONVERT(XML, N'<Info><Superficie>524</Superficie><Poblacion Densidad="52.4">27462</Poblacion></Info>')),
        ('VI', N'Olivar', CONVERT(XML, N'<Info><Superficie>45</Superficie><Poblacion Densidad="324.9">14624</Poblacion></Info>')),
        ('VI', N'Peumo', CONVERT(XML, N'<Info><Superficie>153.1</Superficie><Poblacion Densidad="97.7">14952</Poblacion></Info>')),
        ('VI', N'Pichidegua', CONVERT(XML, N'<Info><Superficie>320</Superficie><Poblacion Densidad="64.8">20743</Poblacion></Info>')),
        ('VI', N'Quinta de Tilcoco', CONVERT(XML, N'<Info><Superficie>93</Superficie><Poblacion Densidad="149.2">13877</Poblacion></Info>')),
        ('VI', N'Rengo', CONVERT(XML, N'<Info><Superficie>755</Superficie><Poblacion Densidad="84.3">63710</Poblacion></Info>')),
        ('VI', N'Requínoa', CONVERT(XML, N'<Info><Superficie>673</Superficie><Poblacion Densidad="45.1">30371</Poblacion></Info>')),
        ('VI', N'San Vicente', CONVERT(XML, N'<Info><Superficie>497.8</Superficie><Poblacion Densidad="101.6">50617</Poblacion></Info>')),
        ('VI', N'Pichilemu', CONVERT(XML, N'<Info><Superficie>749.1</Superficie><Poblacion Densidad="23.8">17882</Poblacion></Info>')),
        ('VI', N'La Estrella', CONVERT(XML, N'<Info><Superficie>435</Superficie><Poblacion Densidad="7.15">3114</Poblacion></Info>')),
        ('VI', N'Litueche', CONVERT(XML, N'<Info><Superficie>619</Superficie><Poblacion Densidad="10.9">6765</Poblacion></Info>')),
        ('VI', N'Marchigüe', CONVERT(XML, N'<Info><Superficie>660</Superficie><Poblacion Densidad="11.5">7632</Poblacion></Info>')),
        ('VI', N'Navidad', CONVERT(XML, N'<Info><Superficie>300</Superficie><Poblacion Densidad="23">6904</Poblacion></Info>')),
        ('VI', N'Paredones', CONVERT(XML, N'<Info><Superficie>562</Superficie><Poblacion Densidad="11.2">6349</Poblacion></Info>')),
        ('VI', N'San Fernando', CONVERT(XML, N'<Info><Superficie>2441</Superficie><Poblacion Densidad="32.2">78642</Poblacion></Info>')),
        ('VI', N'Chépica', CONVERT(XML, N'<Info><Superficie>503</Superficie><Poblacion Densidad="31.6">15925</Poblacion></Info>')),
        ('VI', N'Chimbarongo', CONVERT(XML, N'<Info><Superficie>498</Superficie><Poblacion Densidad="75.6">37696</Poblacion></Info>')),
        ('VI', N'Lolol', CONVERT(XML, N'<Info><Superficie>597</Superficie><Poblacion Densidad="12.2">7289</Poblacion></Info>')),
        ('VI', N'Nancagua', CONVERT(XML, N'<Info><Superficie>111</Superficie><Poblacion Densidad="172.4">19141</Poblacion></Info>')),
        ('VI', N'Palmilla', CONVERT(XML, N'<Info><Superficie>237</Superficie><Poblacion Densidad="56.1">13299</Poblacion></Info>')),
        ('VI', N'Peralillo', CONVERT(XML, N'<Info><Superficie>282.6</Superficie><Poblacion Densidad="41.8">11848</Poblacion></Info>')),
        ('VI', N'Placilla', CONVERT(XML, N'<Info><Superficie>146.9</Superficie><Poblacion Densidad="62.3">9164</Poblacion></Info>')),
        ('VI', N'Pumanque', CONVERT(XML, N'<Info><Superficie>441</Superficie><Poblacion Densidad="8">3531</Poblacion></Info>')),
        ('VI', N'Santa Cruz', CONVERT(XML, N'<Info><Superficie>419.5</Superficie><Poblacion Densidad="97.8">41096</Poblacion></Info>')),
        ('VII', N'Talca', CONVERT(XML, N'<Info><Superficie>232</Superficie><Poblacion Densidad="1016">236724</Poblacion></Info>')),
        ('VII', N'Constitución', CONVERT(XML, N'<Info><Superficie>1344</Superficie><Poblacion Densidad="37.4">50348</Poblacion></Info>')),
        ('VII', N'Curepto', CONVERT(XML, N'<Info><Superficie>1073.8</Superficie><Poblacion Densidad="8.77">9426</Poblacion></Info>')),
        ('VII', N'Empedrado', CONVERT(XML, N'<Info><Superficie>565</Superficie><Poblacion Densidad="7.44">4206</Poblacion></Info>')),
        ('VII', N'Maule', CONVERT(XML, N'<Info><Superficie>190</Superficie><Poblacion Densidad="315.7">60000</Poblacion></Info>')),
        ('VII', N'Pelarco', CONVERT(XML, N'<Info><Superficie>332</Superficie><Poblacion Densidad="27.3">9083</Poblacion></Info>')),
        ('VII', N'Pencahue', CONVERT(XML, N'<Info><Superficie>956.8</Superficie><Poblacion Densidad="8.98">8601</Poblacion></Info>')),
        ('VII', N'Río Claro', CONVERT(XML, N'<Info><Superficie>431</Superficie><Poblacion Densidad="34.2">14753</Poblacion></Info>')),
        ('VII', N'San Clemente', CONVERT(XML, N'<Info><Superficie>4504</Superficie><Poblacion Densidad="10.2">46292</Poblacion></Info>')),
        ('VII', N'San Rafael', CONVERT(XML, N'<Info><Superficie>263.5</Superficie><Poblacion Densidad="17.9">9959</Poblacion></Info>')),
        ('VII', N'Cauquenes', CONVERT(XML, N'<Info><Superficie>2216</Superficie><Poblacion Densidad="19.9">50441</Poblacion></Info>')),
        ('VII', N'Chanco', CONVERT(XML, N'<Info><Superficie>530</Superficie><Poblacion Densidad="17.6">9331</Poblacion></Info>')),
        ('VII', N'Pelluhue', CONVERT(XML, N'<Info><Superficie>371</Superficie><Poblacion Densidad="21.8">8092</Poblacion></Info>')),
        ('VII', N'Curicó', CONVERT(XML, N'<Info><Superficie>1328</Superficie><Poblacion Densidad="123.2">149626</Poblacion></Info>')),
        ('VII', N'Hualañé', CONVERT(XML, N'<Info><Superficie>629</Superficie><Poblacion Densidad="16.2">10222</Poblacion></Info>')),
        ('VII', N'Licantén', CONVERT(XML, N'<Info><Superficie>273</Superficie><Poblacion Densidad="25.6">6989</Poblacion></Info>')),
        ('VII', N'Molina', CONVERT(XML, N'<Info><Superficie>1552</Superficie><Poblacion Densidad="32">49800</Poblacion></Info>')),
        ('VII', N'Rauco', CONVERT(XML, N'<Info><Superficie>309</Superficie><Poblacion Densidad="36.4">11248</Poblacion></Info>')),
        ('VII', N'Romeral', CONVERT(XML, N'<Info><Superficie>1597</Superficie><Poblacion Densidad="10.1">16170</Poblacion></Info>')),
        ('VII', N'Sagrada Familia', CONVERT(XML, N'<Info><Superficie>548.8</Superficie><Poblacion Densidad="35.4">19469</Poblacion></Info>')),
        ('VII', N'Teno', CONVERT(XML, N'<Info><Superficie>618.4</Superficie><Poblacion Densidad="49.9">30850</Poblacion></Info>')),
        ('VII', N'Vichuquén', CONVERT(XML, N'<Info><Superficie>426</Superficie><Poblacion Densidad="10.2">4381</Poblacion></Info>')),
        ('VII', N'Linares', CONVERT(XML, N'<Info><Superficie>1466</Superficie><Poblacion Densidad="68.9">101073</Poblacion></Info>')),
        ('VII', N'Colbún', CONVERT(XML, N'<Info><Superficie>2899.9</Superficie><Poblacion Densidad="7.78">22565</Poblacion></Info>')),
        ('VII', N'Longaví', CONVERT(XML, N'<Info><Superficie>1454</Superficie><Poblacion Densidad="22.5">32810</Poblacion></Info>')),
        ('VII', N'Parral', CONVERT(XML, N'<Info><Superficie>1638</Superficie><Poblacion Densidad="27.1">44544</Poblacion></Info>')),
        ('VII', N'Retiro', CONVERT(XML, N'<Info><Superficie>827</Superficie><Poblacion Densidad="25.4">21071</Poblacion></Info>')),
        ('VII', N'San Javier', CONVERT(XML, N'<Info><Superficie>1313</Superficie><Poblacion Densidad="37.6">49451</Poblacion></Info>')),
        ('VII', N'Villa Alegre', CONVERT(XML, N'<Info><Superficie>190</Superficie><Poblacion Densidad="92.1">17512</Poblacion></Info>')),
        ('VII', N'Yerbas Buenas', CONVERT(XML, N'<Info><Superficie>262</Superficie><Poblacion Densidad="73.2">19200</Poblacion></Info>')),
        ('XVI', N'Chillán', CONVERT(XML, N'<Info><Superficie>511.2</Superficie><Poblacion Densidad="388.6">198624</Poblacion></Info>')),
        ('XVI', N'Bulnes', CONVERT(XML, N'<Info><Superficie>425.4</Superficie><Poblacion Densidad="53.1">22607</Poblacion></Info>')),
        ('XVI', N'Chillán Viejo', CONVERT(XML, N'<Info><Superficie>291.8</Superficie><Poblacion Densidad="115.8">33827</Poblacion></Info>')),
        ('XVI', N'El Carmen', CONVERT(XML, N'<Info><Superficie>664.3</Superficie><Poblacion Densidad="18.5">12334</Poblacion></Info>')),
        ('XVI', N'Pemuco', CONVERT(XML, N'<Info><Superficie>562.7</Superficie><Poblacion Densidad="15.3">8639</Poblacion></Info>')),
        ('XVI', N'Pinto', CONVERT(XML, N'<Info><Superficie>1164</Superficie><Poblacion Densidad="10.2">11880</Poblacion></Info>')),
        ('XVI', N'Quillón', CONVERT(XML, N'<Info><Superficie>423</Superficie><Poblacion Densidad="44.3">18777</Poblacion></Info>')),
        ('XVI', N'San Ignacio', CONVERT(XML, N'<Info><Superficie>363.6</Superficie><Poblacion Densidad="45.6">16624</Poblacion></Info>')),
        ('XVI', N'Yungay', CONVERT(XML, N'<Info><Superficie>823.5</Superficie><Poblacion Densidad="22.5">18596</Poblacion></Info>')),
        ('XVI', N'Quirihue', CONVERT(XML, N'<Info><Superficie>589</Superficie><Poblacion Densidad="20.6">12192</Poblacion></Info>')),
        ('XVI', N'Cobquecura', CONVERT(XML, N'<Info><Superficie>570.3</Superficie><Poblacion Densidad="9.25">5275</Poblacion></Info>')),
        ('XVI', N'Coelemu', CONVERT(XML, N'<Info><Superficie>342.3</Superficie><Poblacion Densidad="49.2">16845</Poblacion></Info>')),
        ('XVI', N'Ninhue', CONVERT(XML, N'<Info><Superficie>401.2</Superficie><Poblacion Densidad="13.5">5414</Poblacion></Info>')),
        ('XVI', N'Portezuelo', CONVERT(XML, N'<Info><Superficie>282.3</Superficie><Poblacion Densidad="17.5">4940</Poblacion></Info>')),
        ('XVI', N'Ránquil', CONVERT(XML, N'<Info><Superficie>248.3</Superficie><Poblacion Densidad="25.2">6261</Poblacion></Info>')),
        ('XVI', N'Treguaco', CONVERT(XML, N'<Info><Superficie>313.1</Superficie><Poblacion Densidad="18.1">5696</Poblacion></Info>')),
        ('XVI', N'San Carlos', CONVERT(XML, N'<Info><Superficie>874</Superficie><Poblacion Densidad="64.3">56252</Poblacion></Info>')),
        ('XVI', N'Coihueco', CONVERT(XML, N'<Info><Superficie>1776.6</Superficie><Poblacion Densidad="15.9">28375</Poblacion></Info>')),
        ('XVI', N'Ñiquén', CONVERT(XML, N'<Info><Superficie>493.1</Superficie><Poblacion Densidad="23.4">11567</Poblacion></Info>')),
        ('XVI', N'San Fabián', CONVERT(XML, N'<Info><Superficie>1568.3</Superficie><Poblacion Densidad="2.96">4654</Poblacion></Info>')),
        ('XVI', N'San Nicolás', CONVERT(XML, N'<Info><Superficie>490.5</Superficie><Poblacion Densidad="24.7">12172</Poblacion></Info>')),
        ('VIII', N'Concepción', CONVERT(XML, N'<Info><Superficie>221.6</Superficie><Poblacion Densidad="1072.4">238092</Poblacion></Info>')),
        ('VIII', N'Coronel', CONVERT(XML, N'<Info><Superficie>279.4</Superficie><Poblacion Densidad="451">125829</Poblacion></Info>')),
        ('VIII', N'Chiguayante', CONVERT(XML, N'<Info><Superficie>71.5</Superficie><Poblacion Densidad="1266.3">91180</Poblacion></Info>')),
        ('VIII', N'Florida', CONVERT(XML, N'<Info><Superficie>608.6</Superficie><Poblacion Densidad="19.4">11841</Poblacion></Info>')),
        ('VIII', N'Hualqui', CONVERT(XML, N'<Info><Superficie>530.5</Superficie><Poblacion Densidad="49.3">26201</Poblacion></Info>')),
        ('VIII', N'Lota', CONVERT(XML, N'<Info><Superficie>135.8</Superficie><Poblacion Densidad="336.3">45750</Poblacion></Info>')),
        ('VIII', N'Penco', CONVERT(XML, N'<Info><Superficie>107.6</Superficie><Poblacion Densidad="461.7">49865</Poblacion></Info>')),
        ('VIII', N'San Pedro de La Paz', CONVERT(XML, N'<Info><Superficie>112.5</Superficie><Poblacion Densidad="1291.2">145906</Poblacion></Info>')),
        ('VIII', N'Santa Juana', CONVERT(XML, N'<Info><Superficie>731.2</Superficie><Poblacion Densidad="20.2">14779</Poblacion></Info>')),
        ('VIII', N'Talcahuano', CONVERT(XML, N'<Info><Superficie>92.3</Superficie><Poblacion Densidad="1721.1">158345</Poblacion></Info>')),
        ('VIII', N'Tomé', CONVERT(XML, N'<Info><Superficie>494.5</Superficie><Poblacion Densidad="118.6">58729</Poblacion></Info>')),
        ('VIII', N'Hualpén', CONVERT(XML, N'<Info><Superficie>53.5</Superficie><Poblacion Densidad="1802.3">97273</Poblacion></Info>')),
        ('VIII', N'Lebu', CONVERT(XML, N'<Info><Superficie>561.4</Superficie><Poblacion Densidad="48.3">27100</Poblacion></Info>')),
        ('VIII', N'Arauco', CONVERT(XML, N'<Info><Superficie>956.1</Superficie><Poblacion Densidad="40.4">38679</Poblacion></Info>')),
        ('VIII', N'Cañete', CONVERT(XML, N'<Info><Superficie>1089.2</Superficie><Poblacion Densidad="33.9">37003</Poblacion></Info>')),
        ('VIII', N'Contulmo', CONVERT(XML, N'<Info><Superficie>638.8</Superficie><Poblacion Densidad="9.9">6330</Poblacion></Info>')),
        ('VIII', N'Curanilahue', CONVERT(XML, N'<Info><Superficie>994.3</Superficie><Poblacion Densidad="34">33892</Poblacion></Info>')),
        ('VIII', N'Los Álamos', CONVERT(XML, N'<Info><Superficie>599.1</Superficie><Poblacion Densidad="37.6">22524</Poblacion></Info>')),
        ('VIII', N'Tirúa', CONVERT(XML, N'<Info><Superficie>624.4</Superficie><Poblacion Densidad="17.6">11019</Poblacion></Info>')),
        ('VIII', N'Los Ángeles', CONVERT(XML, N'<Info><Superficie>1748.2</Superficie><Poblacion Densidad="125">218515</Poblacion></Info>')),
        ('VIII', N'Antuco', CONVERT(XML, N'<Info><Superficie>1884.1</Superficie><Poblacion Densidad="2.28">4306</Poblacion></Info>')),
        ('VIII', N'Cabrero', CONVERT(XML, N'<Info><Superficie>639.8</Superficie><Poblacion Densidad="48">30725</Poblacion></Info>')),
        ('VIII', N'Laja', CONVERT(XML, N'<Info><Superficie>339.8</Superficie><Poblacion Densidad="70.2">23873</Poblacion></Info>')),
        ('VIII', N'Mulchén', CONVERT(XML, N'<Info><Superficie>1925.3</Superficie><Poblacion Densidad="16.1">31041</Poblacion></Info>')),
        ('VIII', N'Nacimiento', CONVERT(XML, N'<Info><Superficie>934.9</Superficie><Poblacion Densidad="29.8">27944</Poblacion></Info>')),
        ('VIII', N'Negrete', CONVERT(XML, N'<Info><Superficie>156.5</Superficie><Poblacion Densidad="66.4">10429</Poblacion></Info>')),
        ('VIII', N'Quilaco', CONVERT(XML, N'<Info><Superficie>1123.7</Superficie><Poblacion Densidad="3.71">4179</Poblacion></Info>')),
        ('VIII', N'Quilleco', CONVERT(XML, N'<Info><Superficie>1121.8</Superficie><Poblacion Densidad="8.94">10032</Poblacion></Info>')),
        ('VIII', N'San Rosendo', CONVERT(XML, N'<Info><Superficie>92.4</Superficie><Poblacion Densidad="39.2">3611</Poblacion></Info>')),
        ('VIII', N'Santa Bárbara', CONVERT(XML, N'<Info><Superficie>1254.9</Superficie><Poblacion Densidad="11.6">14592</Poblacion></Info>')),
        ('VIII', N'Tucapel', CONVERT(XML, N'<Info><Superficie>914.9</Superficie><Poblacion Densidad="16.6">15205</Poblacion></Info>')),
        ('VIII', N'Yumbel', CONVERT(XML, N'<Info><Superficie>727</Superficie><Poblacion Densidad="30.4">22132</Poblacion></Info>')),
        ('VIII', N'Alto Biobío', CONVERT(XML, N'<Info><Superficie>2124.6</Superficie><Poblacion Densidad="3.18">6775</Poblacion></Info>')),
        ('IX', N'Temuco', CONVERT(XML, N'<Info><Superficie>464</Superficie><Poblacion Densidad="652.8">302931</Poblacion></Info>')),
        ('IX', N'Carahue', CONVERT(XML, N'<Info><Superficie>1340.6</Superficie><Poblacion Densidad="19">25486</Poblacion></Info>')),
        ('IX', N'Cunco', CONVERT(XML, N'<Info><Superficie>1906.5</Superficie><Poblacion Densidad="9.46">18055</Poblacion></Info>')),
        ('IX', N'Curarrehue', CONVERT(XML, N'<Info><Superficie>1170.7</Superficie><Poblacion Densidad="6.66">7802</Poblacion></Info>')),
        ('IX', N'Freire', CONVERT(XML, N'<Info><Superficie>935.2</Superficie><Poblacion Densidad="27.2">25446</Poblacion></Info>')),
        ('IX', N'Galvarino', CONVERT(XML, N'<Info><Superficie>568.2</Superficie><Poblacion Densidad="22.2">12633</Poblacion></Info>')),
        ('IX', N'Gorbea', CONVERT(XML, N'<Info><Superficie>694.5</Superficie><Poblacion Densidad="21.7">15148</Poblacion></Info>')),
        ('IX', N'Lautaro', CONVERT(XML, N'<Info><Superficie>901.1</Superficie><Poblacion Densidad="45.2">40746</Poblacion></Info>')),
        ('IX', N'Loncoche', CONVERT(XML, N'<Info><Superficie>976.8</Superficie><Poblacion Densidad="25.3">24739</Poblacion></Info>')),
        ('IX', N'Melipeuco', CONVERT(XML, N'<Info><Superficie>1107.3</Superficie><Poblacion Densidad="5.65">6265</Poblacion></Info>')),
        ('IX', N'Nueva Imperial', CONVERT(XML, N'<Info><Superficie>732.5</Superficie><Poblacion Densidad="46">33777</Poblacion></Info>')),
        ('IX', N'Padre Las Casas', CONVERT(XML, N'<Info><Superficie>400.7</Superficie><Poblacion Densidad="204.7">82110</Poblacion></Info>')),
        ('IX', N'Perquenco', CONVERT(XML, N'<Info><Superficie>330.7</Superficie><Poblacion Densidad="21.8">7223</Poblacion></Info>')),
        ('IX', N'Pitrufquén', CONVERT(XML, N'<Info><Superficie>580.7</Superficie><Poblacion Densidad="44.9">26096</Poblacion></Info>')),
        ('IX', N'Pucón', CONVERT(XML, N'<Info><Superficie>1248.5</Superficie><Poblacion Densidad="23.8">29782</Poblacion></Info>')),
        ('IX', N'Saavedra', CONVERT(XML, N'<Info><Superficie>400.8</Superficie><Poblacion Densidad="31.9">12793</Poblacion></Info>')),
        ('IX', N'Teodoro Schmidt', CONVERT(XML, N'<Info><Superficie>649.9</Superficie><Poblacion Densidad="24.2">15786</Poblacion></Info>')),
        ('IX', N'Toltén', CONVERT(XML, N'<Info><Superficie>860.4</Superficie><Poblacion Densidad="11.6">10055</Poblacion></Info>')),
        ('IX', N'Vilcún', CONVERT(XML, N'<Info><Superficie>1420.9</Superficie><Poblacion Densidad="21.6">30766</Poblacion></Info>')),
        ('IX', N'Villarrica', CONVERT(XML, N'<Info><Superficie>1291.1</Superficie><Poblacion Densidad="45.7">59103</Poblacion></Info>')),
        ('IX', N'Cholchol', CONVERT(XML, N'<Info><Superficie>427.9</Superficie><Poblacion Densidad="28.8">12341</Poblacion></Info>')),
        ('IX', N'Angol', CONVERT(XML, N'<Info><Superficie>1194.4</Superficie><Poblacion Densidad="46.9">56058</Poblacion></Info>')),
        ('IX', N'Collipulli', CONVERT(XML, N'<Info><Superficie>1295.9</Superficie><Poblacion Densidad="20.1">26148</Poblacion></Info>')),
        ('IX', N'Curacautín', CONVERT(XML, N'<Info><Superficie>1664</Superficie><Poblacion Densidad="10.9">18178</Poblacion></Info>')),
        ('IX', N'Ercilla', CONVERT(XML, N'<Info><Superficie>499.7</Superficie><Poblacion Densidad="16.9">8458</Poblacion></Info>')),
        ('IX', N'Lonquimay', CONVERT(XML, N'<Info><Superficie>3914.2</Superficie><Poblacion Densidad="2.82">11049</Poblacion></Info>')),
        ('IX', N'Los Sauces', CONVERT(XML, N'<Info><Superficie>849.8</Superficie><Poblacion Densidad="8.84">7517</Poblacion></Info>')),
        ('IX', N'Lumaco', CONVERT(XML, N'<Info><Superficie>1119</Superficie><Poblacion Densidad="8.98">10050</Poblacion></Info>')),
        ('IX', N'Purén', CONVERT(XML, N'<Info><Superficie>464.9</Superficie><Poblacion Densidad="26.2">12188</Poblacion></Info>')),
        ('IX', N'Renaico', CONVERT(XML, N'<Info><Superficie>267.4</Superficie><Poblacion Densidad="40.4">10833</Poblacion></Info>')),
        ('IX', N'Traiguén', CONVERT(XML, N'<Info><Superficie>908</Superficie><Poblacion Densidad="21.2">19314</Poblacion></Info>')),
        ('IX', N'Victoria', CONVERT(XML, N'<Info><Superficie>1256</Superficie><Poblacion Densidad="28.2">35467</Poblacion></Info>')),
        ('XIV', N'Valdivia', CONVERT(XML, N'<Info><Superficie>1016</Superficie><Poblacion Densidad="173.9">176774</Poblacion></Info>')),
        ('XIV', N'Corral', CONVERT(XML, N'<Info><Superficie>767</Superficie><Poblacion Densidad="7.1">5447</Poblacion></Info>')),
        ('XIV', N'Lanco', CONVERT(XML, N'<Info><Superficie>532.4</Superficie><Poblacion Densidad="33.1">17652</Poblacion></Info>')),
        ('XIV', N'Los Lagos', CONVERT(XML, N'<Info><Superficie>1791.2</Superficie><Poblacion Densidad="11.4">20518</Poblacion></Info>')),
        ('XIV', N'Máfil', CONVERT(XML, N'<Info><Superficie>583</Superficie><Poblacion Densidad="12.6">7389</Poblacion></Info>')),
        ('XIV', N'Mariquina', CONVERT(XML, N'<Info><Superficie>1320.5</Superficie><Poblacion Densidad="17.6">23350</Poblacion></Info>')),
        ('XIV', N'Paillaco', CONVERT(XML, N'<Info><Superficie>896</Superficie><Poblacion Densidad="23.2">20798</Poblacion></Info>')),
        ('XIV', N'Panguipulli', CONVERT(XML, N'<Info><Superficie>3292</Superficie><Poblacion Densidad="10.9">35991</Poblacion></Info>')),
        ('XIV', N'La Unión', CONVERT(XML, N'<Info><Superficie>2137</Superficie><Poblacion Densidad="18.5">39538</Poblacion></Info>')),
        ('XIV', N'Futrono', CONVERT(XML, N'<Info><Superficie>2267.5</Superficie><Poblacion Densidad="6.72">15261</Poblacion></Info>')),
        ('XIV', N'Lago Ranco', CONVERT(XML, N'<Info><Superficie>1763.3</Superficie><Poblacion Densidad="5.83">10292</Poblacion></Info>')),
        ('XIV', N'Río Bueno', CONVERT(XML, N'<Info><Superficie>2211.7</Superficie><Poblacion Densidad="14.8">32925</Poblacion></Info>')),
        ('X', N'Puerto Montt', CONVERT(XML, N'<Info><Superficie>1673</Superficie><Poblacion Densidad="147">269398</Poblacion></Info>')),
        ('X', N'Calbuco', CONVERT(XML, N'<Info><Superficie>590.8</Superficie><Poblacion Densidad="62.1">36744</Poblacion></Info>')),
        ('X', N'Cochamó', CONVERT(XML, N'<Info><Superficie>3910.8</Superficie><Poblacion Densidad="1.02">4006</Poblacion></Info>')),
        ('X', N'Fresia', CONVERT(XML, N'<Info><Superficie>1278.1</Superficie><Poblacion Densidad="9.9">12656</Poblacion></Info>')),
        ('X', N'Frutillar', CONVERT(XML, N'<Info><Superficie>831.4</Superficie><Poblacion Densidad="24.3">20223</Poblacion></Info>')),
        ('X', N'Los Muermos', CONVERT(XML, N'<Info><Superficie>1245.8</Superficie><Poblacion Densidad="14.2">17817</Poblacion></Info>')),
        ('X', N'Llanquihue', CONVERT(XML, N'<Info><Superficie>420.8</Superficie><Poblacion Densidad="44.2">18621</Poblacion></Info>')),
        ('X', N'Maullín', CONVERT(XML, N'<Info><Superficie>860.8</Superficie><Poblacion Densidad="17.2">14894</Poblacion></Info>')),
        ('X', N'Puerto Varas', CONVERT(XML, N'<Info><Superficie>4064.9</Superficie><Poblacion Densidad="11.9">48620</Poblacion></Info>')),
        ('X', N'Castro', CONVERT(XML, N'<Info><Superficie>472.5</Superficie><Poblacion Densidad="100.6">47607</Poblacion></Info>')),
        ('X', N'Ancud', CONVERT(XML, N'<Info><Superficie>1752.4</Superficie><Poblacion Densidad="24.2">42458</Poblacion></Info>')),
        ('X', N'Chonchi', CONVERT(XML, N'<Info><Superficie>1362.1</Superficie><Poblacion Densidad="11.7">16013</Poblacion></Info>')),
        ('X', N'Curaco de Vélez', CONVERT(XML, N'<Info><Superficie>80</Superficie><Poblacion Densidad="50.8">4066</Poblacion></Info>')),
        ('X', N'Dalcahue', CONVERT(XML, N'<Info><Superficie>1239.4</Superficie><Poblacion Densidad="12.1">15069</Poblacion></Info>')),
        ('X', N'Puqueldón', CONVERT(XML, N'<Info><Superficie>97.3</Superficie><Poblacion Densidad="43.3">4201</Poblacion></Info>')),
        ('X', N'Queilén', CONVERT(XML, N'<Info><Superficie>332.9</Superficie><Poblacion Densidad="16.6">5543</Poblacion></Info>')),
        ('X', N'Quellón', CONVERT(XML, N'<Info><Superficie>3244</Superficie><Poblacion Densidad="9.03">29309</Poblacion></Info>')),
        ('X', N'Quemchi', CONVERT(XML, N'<Info><Superficie>440.3</Superficie><Poblacion Densidad="19.9">8783</Poblacion></Info>')),
        ('X', N'Quinchao', CONVERT(XML, N'<Info><Superficie>160.7</Superficie><Poblacion Densidad="51.5">8298</Poblacion></Info>')),
        ('X', N'Osorno', CONVERT(XML, N'<Info><Superficie>951</Superficie><Poblacion Densidad="182.3">173410</Poblacion></Info>')),
        ('X', N'Puerto Octay', CONVERT(XML, N'<Info><Superficie>1795.7</Superficie><Poblacion Densidad="5.11">9192</Poblacion></Info>')),
        ('X', N'Purranque', CONVERT(XML, N'<Info><Superficie>1458.8</Superficie><Poblacion Densidad="14.4">21080</Poblacion></Info>')),
        ('X', N'Puyehue', CONVERT(XML, N'<Info><Superficie>1597.9</Superficie><Poblacion Densidad="7.37">11787</Poblacion></Info>')),
        ('X', N'Río Negro', CONVERT(XML, N'<Info><Superficie>1265.7</Superficie><Poblacion Densidad="11.2">14275</Poblacion></Info>')),
        ('X', N'San Juan de la Costa', CONVERT(XML, N'<Info><Superficie>1517</Superficie><Poblacion Densidad="5.03">7639</Poblacion></Info>')),
        ('X', N'San Pablo', CONVERT(XML, N'<Info><Superficie>637.3</Superficie><Poblacion Densidad="16.5">10553</Poblacion></Info>')),
        ('X', N'Chaitén', CONVERT(XML, N'<Info><Superficie>8470.5</Superficie><Poblacion Densidad="0.59">5020</Poblacion></Info>')),
        ('X', N'Futaleufú', CONVERT(XML, N'<Info><Superficie>1280</Superficie><Poblacion Densidad="2.19">2806</Poblacion></Info>')),
        ('X', N'Hualaihué', CONVERT(XML, N'<Info><Superficie>2787.7</Superficie><Poblacion Densidad="3.41">9525</Poblacion></Info>')),
        ('X', N'Palena', CONVERT(XML, N'<Info><Superficie>2763.7</Superficie><Poblacion Densidad="0.66">1827</Poblacion></Info>')),
        ('XI', N'Coyhaique', CONVERT(XML, N'<Info><Superficie>7290.2</Superficie><Poblacion Densidad="8.39">61210</Poblacion></Info>')),
        ('XI', N'Lago Verde', CONVERT(XML, N'<Info><Superficie>5422.3</Superficie><Poblacion Densidad="0.16">920</Poblacion></Info>')),
        ('XI', N'Aysén', CONVERT(XML, N'<Info><Superficie>29796.4</Superficie><Poblacion Densidad="0.83">25002</Poblacion></Info>')),
        ('XI', N'Cisnes', CONVERT(XML, N'<Info><Superficie>16093</Superficie><Poblacion Densidad="0.36">5828</Poblacion></Info>')),
        ('XI', N'Guaitecas', CONVERT(XML, N'<Info><Superficie>620.6</Superficie><Poblacion Densidad="2.57">1599</Poblacion></Info>')),
        ('XI', N'Cochrane', CONVERT(XML, N'<Info><Superficie>8599.5</Superficie><Poblacion Densidad="0.42">3685</Poblacion></Info>')),
        ('XI', N'O''Higgins', CONVERT(XML, N'<Info><Superficie>8182.5</Superficie><Poblacion Densidad="0.08">661</Poblacion></Info>')),
        ('XI', N'Tortel', CONVERT(XML, N'<Info><Superficie>19710.6</Superficie><Poblacion Densidad="0.03">572</Poblacion></Info>')),
        ('XI', N'Chile Chico', CONVERT(XML, N'<Info><Superficie>5737.1</Superficie><Poblacion Densidad="0.89">5121</Poblacion></Info>')),
        ('XI', N'Río Ibáñez', CONVERT(XML, N'<Info><Superficie>5997.2</Superficie><Poblacion Densidad="0.45">2699</Poblacion></Info>')),
        ('XII', N'Punta Arenas', CONVERT(XML, N'<Info><Superficie>17846.3</Superficie><Poblacion Densidad="7.95">141984</Poblacion></Info>')),
        ('XII', N'Laguna Blanca', CONVERT(XML, N'<Info><Superficie>3695.6</Superficie><Poblacion Densidad="0.07">264</Poblacion></Info>')),
        ('XII', N'Río Verde', CONVERT(XML, N'<Info><Superficie>17248</Superficie><Poblacion Densidad="0.01">211</Poblacion></Info>')),
        ('XII', N'San Gregorio', CONVERT(XML, N'<Info><Superficie>6883.7</Superficie><Poblacion Densidad="0.09">681</Poblacion></Info>')),
        ('XII', N'Cabo de Hornos', CONVERT(XML, N'<Info><Superficie>15578.7</Superficie><Poblacion Densidad="0.13">1983</Poblacion></Info>')),
        ('XII', N'Antártica', CONVERT(XML, N'<Info><Superficie>1250257.6</Superficie><Poblacion Densidad="0.0001">137</Poblacion></Info>')),
        ('XII', N'Porvenir', CONVERT(XML, N'<Info><Superficie>9707.4</Superficie><Poblacion Densidad="0.75">7323</Poblacion></Info>')),
        ('XII', N'Primavera', CONVERT(XML, N'<Info><Superficie>4253.4</Superficie><Poblacion Densidad="0.16">694</Poblacion></Info>')),
        ('XII', N'Timaukel', CONVERT(XML, N'<Info><Superficie>10758.9</Superficie><Poblacion Densidad="0.02">282</Poblacion></Info>')),
        ('XII', N'Natales', CONVERT(XML, N'<Info><Superficie>49924.1</Superficie><Poblacion Densidad="0.47">23782</Poblacion></Info>')),
        ('XII', N'Torres del Paine', CONVERT(XML, N'<Info><Superficie>6630</Superficie><Poblacion Densidad="0.15">1021</Poblacion></Info>')),
        ('RM', N'Santiago', CONVERT(XML, N'<Info><Superficie>23.2</Superficie><Poblacion Densidad="21875.9">503147</Poblacion></Info>')),
        ('RM', N'Cerrillos', CONVERT(XML, N'<Info><Superficie>21</Superficie><Poblacion Densidad="4236">88956</Poblacion></Info>')),
        ('RM', N'Cerro Navia', CONVERT(XML, N'<Info><Superficie>11</Superficie><Poblacion Densidad="12951.3">142465</Poblacion></Info>')),
        ('RM', N'Conchalí', CONVERT(XML, N'<Info><Superficie>10.7</Superficie><Poblacion Densidad="12654">139195</Poblacion></Info>')),
        ('RM', N'El Bosque', CONVERT(XML, N'<Info><Superficie>14.2</Superficie><Poblacion Densidad="12285.7">172000</Poblacion></Info>')),
        ('RM', N'Estación Central', CONVERT(XML, N'<Info><Superficie>15</Superficie><Poblacion Densidad="13786.1">206792</Poblacion></Info>')),
        ('RM', N'Huechuraba', CONVERT(XML, N'<Info><Superficie>44.8</Superficie><Poblacion Densidad="2500.6">112528</Poblacion></Info>')),
        ('RM', N'Independencia', CONVERT(XML, N'<Info><Superficie>7</Superficie><Poblacion Densidad="20295">142065</Poblacion></Info>')),
        ('RM', N'La Cisterna', CONVERT(XML, N'<Info><Superficie>10</Superficie><Poblacion Densidad="10043.4">100434</Poblacion></Info>')),
        ('RM', N'La Florida', CONVERT(XML, N'<Info><Superficie>70.2</Superficie><Poblacion Densidad="5749">402433</Poblacion></Info>')),
        ('RM', N'La Granja', CONVERT(XML, N'<Info><Superficie>10</Superficie><Poblacion Densidad="12255.7">122557</Poblacion></Info>')),
        ('RM', N'La Pintana', CONVERT(XML, N'<Info><Superficie>30.6</Superficie><Poblacion Densidad="6107.5">189335</Poblacion></Info>')),
        ('RM', N'La Reina', CONVERT(XML, N'<Info><Superficie>23</Superficie><Poblacion Densidad="4358.7">100252</Poblacion></Info>')),
        ('RM', N'Las Condes', CONVERT(XML, N'<Info><Superficie>99</Superficie><Poblacion Densidad="3341">330759</Poblacion></Info>')),
        ('RM', N'Lo Barnechea', CONVERT(XML, N'<Info><Superficie>1024</Superficie><Poblacion Densidad="121.1">124076</Poblacion></Info>')),
        ('RM', N'Lo Espejo', CONVERT(XML, N'<Info><Superficie>7</Superficie><Poblacion Densidad="14837.8">103865</Poblacion></Info>')),
        ('RM', N'Lo Prado', CONVERT(XML, N'<Info><Superficie>7</Superficie><Poblacion Densidad="14914.7">104403</Poblacion></Info>')),
        ('RM', N'Macul', CONVERT(XML, N'<Info><Superficie>12.9</Superficie><Poblacion Densidad="10356.5">134635</Poblacion></Info>')),
        ('RM', N'Maipú', CONVERT(XML, N'<Info><Superficie>135.5</Superficie><Poblacion Densidad="4254.4">578605</Poblacion></Info>')),
        ('RM', N'Ñuñoa', CONVERT(XML, N'<Info><Superficie>16.9</Superficie><Poblacion Densidad="14717.1">250192</Poblacion></Info>')),
        ('RM', N'Pedro Aguirre Cerda', CONVERT(XML, N'<Info><Superficie>10</Superficie><Poblacion Densidad="10780.3">107803</Poblacion></Info>')),
        ('RM', N'Peñalolén', CONVERT(XML, N'<Info><Superficie>54</Superficie><Poblacion Densidad="4940.7">266798</Poblacion></Info>')),
        ('RM', N'Providencia', CONVERT(XML, N'<Info><Superficie>14.3</Superficie><Poblacion Densidad="11267.7">157749</Poblacion></Info>')),
        ('RM', N'Pudahuel', CONVERT(XML, N'<Info><Superficie>197</Superficie><Poblacion Densidad="1284.9">253139</Poblacion></Info>')),
        ('RM', N'Quilicura', CONVERT(XML, N'<Info><Superficie>58</Superficie><Poblacion Densidad="4391.2">254694</Poblacion></Info>')),
        ('RM', N'Quinta Normal', CONVERT(XML, N'<Info><Superficie>13</Superficie><Poblacion Densidad="10489.8">136368</Poblacion></Info>')),
        ('RM', N'Recoleta', CONVERT(XML, N'<Info><Superficie>16</Superficie><Poblacion Densidad="11879.3">190070</Poblacion></Info>')),
        ('RM', N'Renca', CONVERT(XML, N'<Info><Superficie>24</Superficie><Poblacion Densidad="6993.3">160847</Poblacion></Info>')),
        ('RM', N'San Joaquín', CONVERT(XML, N'<Info><Superficie>9.7</Superficie><Poblacion Densidad="10348.5">103485</Poblacion></Info>')),
        ('RM', N'San Miguel', CONVERT(XML, N'<Info><Superficie>10</Superficie><Poblacion Densidad="13305.9">133059</Poblacion></Info>')),
        ('RM', N'San Ramón', CONVERT(XML, N'<Info><Superficie>7</Superficie><Poblacion Densidad="12358.5">86510</Poblacion></Info>')),
        ('RM', N'Vitacura', CONVERT(XML, N'<Info><Superficie>28.3</Superficie><Poblacion Densidad="3456.2">96774</Poblacion></Info>')),
        ('RM', N'Puente Alto', CONVERT(XML, N'<Info><Superficie>88</Superficie><Poblacion Densidad="7339.8">645909</Poblacion></Info>')),
        ('RM', N'Pirque', CONVERT(XML, N'<Info><Superficie>445.3</Superficie><Poblacion Densidad="68.3">30433</Poblacion></Info>')),
        ('RM', N'San José de Maipo', CONVERT(XML, N'<Info><Superficie>4994.8</Superficie><Poblacion Densidad="3.74">18644</Poblacion></Info>')),
        ('RM', N'Colina', CONVERT(XML, N'<Info><Superficie>971.2</Superficie><Poblacion Densidad="1857">180353</Poblacion></Info>')),
        ('RM', N'Lampa', CONVERT(XML, N'<Info><Superficie>452</Superficie><Poblacion Densidad="2807">126898</Poblacion></Info>')),
        ('RM', N'Til Til', CONVERT(XML, N'<Info><Superficie>653</Superficie><Poblacion Densidad="32.8">21477</Poblacion></Info>')),
        ('RM', N'San Bernardo', CONVERT(XML, N'<Info><Superficie>155</Superficie><Poblacion Densidad="2160.2">334836</Poblacion></Info>')),
        ('RM', N'Buin', CONVERT(XML, N'<Info><Superficie>214</Superficie><Poblacion Densidad="5123">109641</Poblacion></Info>')),
        ('RM', N'Calera de Tango', CONVERT(XML, N'<Info><Superficie>73.3</Superficie><Poblacion Densidad="390.7">28525</Poblacion></Info>')),
        ('RM', N'Paine', CONVERT(XML, N'<Info><Superficie>820</Superficie><Poblacion Densidad="100.9">82766</Poblacion></Info>')),
        ('RM', N'Melipilla', CONVERT(XML, N'<Info><Superficie>1345</Superficie><Poblacion Densidad="105.2">141612</Poblacion></Info>')),
        ('RM', N'Alhué', CONVERT(XML, N'<Info><Superficie>845</Superficie><Poblacion Densidad="8.76">7405</Poblacion></Info>')),
        ('RM', N'Curacaví', CONVERT(XML, N'<Info><Superficie>693</Superficie><Poblacion Densidad="52.5">36430</Poblacion></Info>')),
        ('RM', N'María Pinto', CONVERT(XML, N'<Info><Superficie>393.5</Superficie><Poblacion Densidad="37.8">14926</Poblacion></Info>')),
        ('RM', N'San Pedro', CONVERT(XML, N'<Info><Superficie>788</Superficie><Poblacion Densidad="15.1">11953</Poblacion></Info>')),
        ('RM', N'Talagante', CONVERT(XML, N'<Info><Superficie>126</Superficie><Poblacion Densidad="649.5">81838</Poblacion></Info>')),
        ('RM', N'El Monte', CONVERT(XML, N'<Info><Superficie>118</Superficie><Poblacion Densidad="339.1">40014</Poblacion></Info>')),
        ('RM', N'Isla de Maipo', CONVERT(XML, N'<Info><Superficie>189</Superficie><Poblacion Densidad="212.5">40171</Poblacion></Info>')),
        ('RM', N'Padre Hurtado', CONVERT(XML, N'<Info><Superficie>80.8</Superficie><Poblacion Densidad="915.9">74188</Poblacion></Info>')),
        ('RM', N'Peñaflor', CONVERT(XML, N'<Info><Superficie>69</Superficie><Poblacion Densidad="1464.6">101058</Poblacion></Info>'));

    ;WITH ComunasConRegion AS
    (
        SELECT
            R.IdRegion,
            C.NombreComuna,
            C.InformacionAdicional
        FROM @Comunas AS C
        INNER JOIN @Regiones AS SR ON SR.CodigoRegion = C.CodigoRegion
        INNER JOIN dbo.Region AS R ON R.NombreRegion = SR.NombreRegion
    )
    MERGE dbo.Comuna WITH (HOLDLOCK) AS Destino
    USING ComunasConRegion AS Origen
       ON Destino.IdRegion = Origen.IdRegion
      AND Destino.NombreComuna = Origen.NombreComuna
    WHEN MATCHED AND
         ISNULL(CONVERT(NVARCHAR(MAX), Destino.InformacionAdicional), N'') <>
         ISNULL(CONVERT(NVARCHAR(MAX), Origen.InformacionAdicional), N'')
        THEN UPDATE SET
            InformacionAdicional = Origen.InformacionAdicional
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (IdRegion, NombreComuna, InformacionAdicional)
        VALUES (Origen.IdRegion, Origen.NombreComuna, Origen.InformacionAdicional);

    IF (SELECT COUNT(8) FROM @Regiones) <> 16
        THROW 51001, 'La carga no contiene exactamente 16 regiones.', 1;

    IF (SELECT COUNT(8) FROM @Comunas) <> 346
        THROW 51002, 'La carga no contiene exactamente 346 comunas.', 1;

    IF EXISTS
    (
        SELECT 1
        FROM @Comunas AS C
        INNER JOIN @Regiones AS SR ON SR.CodigoRegion = C.CodigoRegion
        INNER JOIN dbo.Region AS R ON R.NombreRegion = SR.NombreRegion
        LEFT JOIN dbo.Comuna AS D  ON D.IdRegion = R.IdRegion
           AND D.NombreComuna = C.NombreComuna
        WHERE D.IdComuna IS NULL
    )
        THROW 51003, 'No fue posible insertar o actualizar todas las comunas.', 1;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

SELECT
    R.IdRegion,
    R.NombreRegion,
    COUNT(C.IdComuna) AS CantidadComunas
FROM dbo.Region AS R
LEFT JOIN dbo.Comuna AS C ON C.IdRegion = R.IdRegion
GROUP BY R.IdRegion, R.NombreRegion
ORDER BY R.IdRegion;

SELECT COUNT(8) AS TotalRegiones FROM dbo.Region;
SELECT COUNT(8) AS TotalComunas FROM dbo.Comuna;
GO
