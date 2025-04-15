alter policy "Enable insert for authenticated users only" on "public"."user_qr_codes" to authenticated
with
    check (true);