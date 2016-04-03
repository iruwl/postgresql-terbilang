CREATE OR REPLACE FUNCTION terbilang(angka numeric)
  RETURNS character varying AS
$BODY$
DECLARE
  kata varchar[] = array['satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan', 'sepuluh', 'sebelas'];
  kalimat varchar = 'Out of range!';
begin

  /*
  * irul@20160403
  * http://www.ortax.org/ortax/?mod=aturan&hlm=404&page=show&id=2173#
  * http://uangindonesia.com/cara-menulis-mata-uang-rupiah-rp-benar/
  * http://stiekalpatarucilengsi.blogspot.co.id/2012/01/pembulatan-di-faktur-pajak.html
  */

  angka = abs(angka);

  if (angka < 12) then
    kalimat = concat('', kata[angka]);
  elseif (angka < 20) then
    kalimat = concat(terbilang(trunc(angka - 10)), ' belas ');
  elseif (angka < 100) then
    kalimat = concat(terbilang(trunc(angka / 10)), ' puluh ', terbilang(angka::numeric % 10));
  elseif (angka < 200) then
    kalimat = concat(' seratus ', terbilang(trunc(angka - 100)));
  elseif (angka < 1000) then
    kalimat = concat(terbilang(trunc(angka / 100)), ' ratus ', terbilang(angka::numeric % 100));
  elseif (angka < 2000) then
    kalimat = concat(' seribu ', terbilang(angka - 1000));
  elseif (angka < 1000000) then
    kalimat = concat(terbilang(trunc(angka / 1000)), ' ribu ', terbilang(angka::numeric % 1000));
  elseif (angka < 1000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000)), ' juta ', terbilang(angka::numeric % 1000000));
  elseif (angka < 1000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000)), ' milyar ', terbilang(angka::numeric % 1000000000));
  elseif (angka < 1000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000)), ' triliun ', terbilang(angka::numeric % 1000000000000));
  elseif (angka < 1000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000)), ' kuadriliun ', terbilang(angka::numeric % 1000000000000000));
  elseif (angka < 1000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000)), ' kuantiliun ', terbilang(angka::numeric % 1000000000000000000));
  elseif (angka < 1000000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000000)), ' sekstiliun ', terbilang(angka::numeric % 1000000000000000000000));
  elseif (angka < 1000000000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000000000)), ' septiliun ', terbilang(angka::numeric % 1000000000000000000000000));
  elseif (angka < 1000000000000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000000000000)), ' oktiliun ', terbilang(angka::numeric % 1000000000000000000000000000));
  elseif (angka < 1000000000000000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000000000000000)), ' noniliun ', terbilang(angka::numeric % 1000000000000000000000000000000));
  elseif (angka < 1000000000000000000000000000000000000) then
    kalimat = concat(terbilang(trunc(angka / 1000000000000000000000000000000000)), ' desiliun ', terbilang(angka::numeric % 1000000000000000000000000000000000));
  end if;

  return trim(kalimat);

end
$BODY$
  LANGUAGE plpgsql IMMUTABLE;
