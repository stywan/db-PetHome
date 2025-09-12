CREATE OR REPLACE TRIGGER trg_auditoria_pagos
AFTER INSERT ON pago
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_pagos (id, pago_id, fecha_evento, descripcion)
    VALUES (seq_auditoria.NEXTVAL, :NEW.id, SYSDATE,
            'Se registró un nuevo pago de ' || :NEW.monto || ' ' || :NEW.moneda);
END;