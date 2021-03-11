1. select nom_lang, fam_lang from IDIOMA where fam_lang='Romance' or fam_lang='Germánica';

2. select cod_emp, AVG(cantidad_proy) from TRADUCTOR group by cod_emp having AVG(cantidad_proy) between 1 and 2;

4. select cod_emp, D.cod_lang from DOMINA D, IDIOMA I where D.cod_lang=I.cod_lang and (nom_lang='inglés' or nom_lang='francés');

5. select P.nom_emp, I.fam_lang, count(*) 'cantidad_lang' from DOMINA D join IDIOMA I using(cod_lang) join PROFESIONAL P using(cod_emp) where fam_lang='romance' group by P.nom_emp;

6. select P.nom_emp, I.fam_lang, count(*) 'cantidad_lang' from DOMINA D join IDIOMA I using(cod_lang) join PROFESIONAL P using(cod_emp) where fam_lang='romance' group by P.nom_emp having cantidad_lang>=2;

7. select cod_emp, cantidad_proy from TRADUCTOR where cantidad_proy>=(select cantidad_proy 'cant_proy_ANA' from (select cod_emp from PROFESIONAL where nom_emp='Ana') T1 join TRADUCTOR T using (cod_emp));

8. select P.nom_emp, I.nom_lang from PROFESIONAL P join DOMINA D using (cod_emp) join IDIOMA I using (cod_lang) where P.nom_emp='Estelle';

9. select cod_lang, nom_lang, cod_proy from IDIOMA I left join PROYECTO P on I.cod_lang=P.cod_langOr or I.cod_lang=P.cod_langMeta having cod_proy is null;

10. update PROFESIONAL P, DOMINA D set cod_lang=104 where P.cod_emp=D.cod_emp and P.nom_emp='Juan Carlos';

11. delete G from PROFESIONAL P join GESTOR G using (cod_emp) where P.nom_emp='Paula';