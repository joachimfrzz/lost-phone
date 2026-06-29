import { adaptBanking } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle } from "../ios/ui/NavBar";
import { formatMoney, formatShortDate } from "../ios/ui/utils";

export function BankingApp({ data }: { data: unknown }) {
  const bank = adaptBanking(data);
  const compte = bank.accounts[0];

  return (
    <AppShell theme="bank">
      <LargeTitle title="Crédit Agricole" />
      <div className="ui-scroll">
        <div className="ui-bank-hero">
          <p style={{ margin: 0, fontSize: 14, opacity: 0.85 }}>{compte?.nom ?? "Compte courant"}</p>
          <p className="ui-bank-hero__amount">{formatMoney(compte?.solde)}</p>
          {bank.holder && <p style={{ margin: 0, fontSize: 13, opacity: 0.8 }}>{bank.holder}</p>}
        </div>
        {bank.summary && (
          <p style={{ padding: "0 20px 12px", fontSize: 13, color: "#666", margin: 0 }}>{bank.summary.slice(0, 200)}…</p>
        )}
        <Group header="Opérations">
          {bank.operations.slice(0, 30).map((op, i) => {
            const montant = op.montant as number | string | undefined;
            const neg = Number(montant) < 0;
            return (
              <Cell
                key={i}
                label={String(op.libelle ?? "")}
                subtitle={`${op.categorie ?? ""} · ${formatShortDate(op.date as string)}`}
                detail={<span style={{ color: neg ? "#ff3b30" : "#34c759", fontWeight: 600 }}>{formatMoney(montant)}</span>}
              />
            );
          })}
        </Group>
      </div>
    </AppShell>
  );
}
