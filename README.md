# DelphiMikolaj
Materiały do seminarium "Tylko grzeczni programiści
dostaną odpowiedź z serwisu REST..." BSC Polska 15 i 18.12.2023

W przykładach z pogodą należy wpisać własne APPID.

W pliku System.NetEncoding.pas poprawiłem dwie metody zgodnie ze źródłami z D11:
function TURLEncoding.EncodeAuth(const Auth: string; const AExtraUnsafeChars: TUnsafeChars): string;
begin
//  Result := Encode(Auth, AuthUnsafeChars + AExtraUnsafeChars, [TEncodeOption.EncodePercent]); //ZS
  Result := Encode(Auth, AuthUnsafeChars + AExtraUnsafeChars, []);
end;

function TURLEncoding.EncodeQuery(const AQuery: string; const AExtraUnsafeChars: TUnsafeChars): string;
begin
//  Result := Encode(AQuery, QueryUnsafeChars + AExtraUnsafeChars, [TEncodeOption.EncodePercent]); //ZS
  Result := Encode(AQuery, QueryUnsafeChars + AExtraUnsafeChars, []);
end;

zmodyfikowany plik należy umieścić w katalogu projektu (a wraz z nim pozostałe, od których jest zależny) i przebudować projekt.