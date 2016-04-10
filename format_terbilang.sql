CREATE OR REPLACE FUNCTION format_terbilang(angka numeric, style int=0, jml_desimal int=-1)
  RETURNS varchar AS
$BODY$
DECLARE
  i int;
  angkanya varchar[];
  bacaan_komanya varchar;
  ada_koma int;
  komanya varchar;
  dibacanya varchar;
begin

  /*
  * irul@20160403
  * https://rubrikbahasa.wordpress.com/2009/02/27/sistem-bilangan-besar/
  * http://www.ortax.org/ortax/?mod=aturan&hlm=404&page=show&id=2173#
  * http://uangindonesia.com/cara-menulis-mata-uang-rupiah-rp-benar/
  * http://stiekalpatarucilengsi.blogspot.co.id/2012/01/pembulatan-di-faktur-pajak.html
  */

  if (jml_desimal > -1) then
    angka = round(angka, jml_desimal);
  end if;

  angkanya = (regexp_split_to_array(angka::varchar, E'\\.'));
  ada_koma = array_length(angkanya, 1);

  dibacanya = trim(terbilang(angkanya[1]::numeric));
  if (dibacanya <> 'Out of range!') then
    if (dibacanya = '') then
      dibacanya = 'nol';
    end if;

    if (ada_koma > 1) then
      for i in
        select regexp_split_to_table(angkanya[2], '')
      loop
        bacaan_komanya = terbilang(i);
        komanya = concat(komanya, case when bacaan_komanya='' then 'nol' else bacaan_komanya end, ' ');
      end loop;
      dibacanya = trim(concat(dibacanya, ' koma ', komanya));
    end if;

    if (angka < 0) then
      dibacanya = concat('minus ', trim(dibacanya));
    end if;

    dibacanya = concat(dibacanya, ' rupiah');
  end if;

  case style
    when 1 then dibacanya = upper(dibacanya);
    when 2 then dibacanya = lower(dibacanya);
    when 3 then dibacanya = initcap(dibacanya);
    else dibacanya = concat(upper(substr(dibacanya,1,1)), right(dibacanya,-1));
  end case;

  return dibacanya;

end
$BODY$
  LANGUAGE plpgsql IMMUTABLE;