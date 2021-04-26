/^[^;]/ { counter += NF }
END { print counter }
