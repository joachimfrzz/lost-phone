import { useState } from "react";
import { adaptFiles, type FileNode } from "../lib/lpsp/adapters";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { LargeTitle, NavBar } from "../ios/ui/NavBar";

export function FilesApp({ data }: { data: unknown }) {
  const roots = adaptFiles(data);
  const [path, setPath] = useState<FileNode[]>(roots);
  const [stack, setStack] = useState<FileNode[][]>([]);
  const [file, setFile] = useState<FileNode | null>(null);

  function openFolder(node: FileNode) {
    if (node.children) {
      setStack((s) => [...s, path]);
      setPath(node.children);
    } else if (node.description) {
      setFile(node);
    }
  }

  function goBack() {
    if (file) { setFile(null); return; }
    const prev = stack.at(-1);
    if (prev) {
      setStack((s) => s.slice(0, -1));
      setPath(prev);
    }
  }

  if (file) {
    return (
      <AppShell theme="files">
        <NavBar title={file.name} backLabel="Fichiers" onBack={() => setFile(null)} />
        <article className="ui-detail">
          <p className="ui-detail__meta">{file.type} · {file.size}</p>
          <p className="ui-detail__meta">{file.date}</p>
          <div className="ui-detail__body">{file.description}</div>
        </article>
      </AppShell>
    );
  }

  return (
    <AppShell theme="files">
      {stack.length > 0 ? (
        <NavBar title="iCloud Drive" backLabel="Retour" onBack={goBack} />
      ) : (
        <LargeTitle title="Fichiers" subtitle="iCloud Drive" />
      )}
      <div className="ui-scroll">
        <Group>
          {path.map((node, i) => (
            <Cell
              key={i}
              icon={<span className="ui-file-icon" />}
              label={node.name}
              subtitle={node.type && node.type !== "folder" ? `${node.type} · ${node.size ?? ""}` : `${node.children?.length ?? 0} éléments`}
              chevron={Boolean(node.children || node.description)}
              onClick={() => openFolder(node)}
            />
          ))}
        </Group>
      </div>
    </AppShell>
  );
}
