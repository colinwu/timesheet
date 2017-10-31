f = $stdin
out = File.new("/tmp/proctest", "w")
while (line = f.gets)
  if (line =~ /--SmTP-MULTIPART-BOUNDARY/)
    break
  end
  out.puts(line)
end
out.close
