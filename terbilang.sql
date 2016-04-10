CREATE OR REPLACE FUNCTION terbilang(angka numeric)
  RETURNS character varying AS
$BODY$
DECLARE
  kata varchar[] = array['satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan', 'sepuluh', 'sebelas'];
  kalimat varchar = 'Out of range!';
begin

  /*
  * irul@20160403
  * https://rubrikbahasa.wordpress.com/2009/02/27/sistem-bilangan-besar/
  * http://www.ortax.org/ortax/?mod=aturan&hlm=404&page=show&id=2173#
  * http://uangindonesia.com/cara-menulis-mata-uang-rupiah-rp-benar/
  * http://stiekalpatarucilengsi.blogspot.co.id/2012/01/pembulatan-di-faktur-pajak.html
  */

  angka = abs(angka);

  if (angka < 12) then
    kalimat = kata[angka];
  elseif (angka < 20) then
    kalimat = concat(terbilang(trunc(angka - 10)), ' belas ');
  elseif (angka < (10^2)) then
    kalimat = concat(terbilang(trunc(angka / 10)), ' puluh ', terbilang(angka::numeric % 10));
  elseif (angka < 200) then
    kalimat = concat(' seratus ', terbilang(trunc(angka - (10^2))));
  elseif (angka < (10^3)) then
    kalimat = concat(terbilang(trunc(angka / (10^2))), ' ratus ', terbilang(angka::numeric % (10^2)));
  elseif (angka < 2000) then
    kalimat = concat(' seribu ', terbilang(angka - (10^3)));
  elseif (angka < (10^6)) then
    kalimat = concat(terbilang(trunc(angka / (10^3))), ' ribu ', terbilang(angka::numeric % (10^3)));
  elseif (angka < (10^9)) then
    kalimat = concat(terbilang(trunc(angka / (10^6))), ' juta ', terbilang(angka::numeric % (10^6)));
  elseif (angka < (10^12)) then
    kalimat = concat(terbilang(trunc(angka / (10^9))), ' milyar ', terbilang(angka::numeric % (10^9)));
  elseif (angka < (10^15)) then
    kalimat = concat(terbilang(trunc(angka / (10^12))), ' triliun ', terbilang(angka::numeric % (10^12)));
  elseif (angka < (10^18)) then
    kalimat = concat(terbilang(trunc(angka / (10^15))), ' kuadriliun ', terbilang(angka::numeric % (10^15)));
  elseif (angka < (10^21)) then
    kalimat = concat(terbilang(trunc(angka / (10^18))), ' kuantiliun ', terbilang(angka::numeric % (10^18)));
  elseif (angka < (10^24)) then
    kalimat = concat(terbilang(trunc(angka / (10^21))), ' sekstiliun ', terbilang(angka::numeric % (10^21)));
  elseif (angka < (10^27)) then
    kalimat = concat(terbilang(trunc(angka / (10^24))), ' septiliun ', terbilang(angka::numeric % (10^24)));
  elseif (angka < (10^30)) then
    kalimat = concat(terbilang(trunc(angka / (10^27))), ' oktiliun ', terbilang(angka::numeric % (10^27)));
  elseif (angka < (10^33)) then
    kalimat = concat(terbilang(trunc(angka / (10^30))), ' noniliun ', terbilang(angka::numeric % (10^30)));
  elseif (angka < (10^36)) then
    kalimat = concat(terbilang(trunc(angka / (10^33))), ' desiliun ', terbilang(angka::numeric % (10^33)));
  end if;

  return trim(kalimat);

end
$BODY$
  LANGUAGE plpgsql IMMUTABLE;
